import SwiftUI

struct AssignmentDetailView: View {
    @Environment(ServicesModel.self) private var services
    @Environment(AuthModel.self) private var auth

    let assignmentID: String

    @State private var assignment: APIClient.AssignmentResponseDTO?
    @State private var error: String?
    @State private var isLoading = false

    var body: some View {
        Group {
            if let error {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                    Text(error)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if isLoading || assignment == nil {
                ProgressView("Loading Assignment…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let assignment {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(assignment.name)
                            .font(.title.bold())
                        if let body = assignment.body, !body.isEmpty {
                            Text(body)
                        }
                        if let due = assignment.dueOn {
                            Text("Due: \(due)")
                                .foregroundStyle(.secondary)
                        }

                        ProgressControls(assignmentID: assignment.id, current: assignment.userProgress)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Assignment")
        .task { await load() }
        .refreshable { await load() }
    }

    private func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let req = try services.api.assignmentByID(id: assignmentID, includeProgress: true, includeFAQs: true)
            self.assignment = try await services.api.performRequest(req)
            self.error = nil
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }
}

private struct ProgressControls: View {
    @Environment(ServicesModel.self) private var services
    let assignmentID: String
    @State var current: String?
    @State private var isSaving = false
    @State private var error: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Progress")
                .font(.headline)
            HStack {
                ForEach(["notStarted", "inProgress", "complete"], id: \.self) { state in
                    Button {
                        Task { await set(state) }
                    } label: {
                        Label(stateLabel(state), systemImage: current == state ? "checkmark.circle.fill" : "circle")
                    }
                    .buttonStyle(.bordered)
                    .disabled(isSaving)
                }
                Spacer()
                Button("Clear") { Task { await clear() } }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .disabled(isSaving)
            }
            if let error { Text(error).foregroundStyle(.red).font(.footnote) }
        }
    }

    private func stateLabel(_ s: String) -> String {
        switch s { case "notStarted": return "Not Started"; case "inProgress": return "In Progress"; case "complete": return "Complete"; default: return s }
    }

    private func set(_ state: String) async {
        isSaving = true
        defer { isSaving = false }
        do {
            _ = try await services.api.assignmentSetProgress(assignmentID: assignmentID, progress: state)
            self.current = state
            self.error = nil
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }

    private func clear() async {
        isSaving = true
        defer { isSaving = false }
        do {
            try await services.api.assignmentClearProgress(assignmentID: assignmentID)
            self.current = nil
            self.error = nil
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }
}

#Preview {
    let services = ServicesModel()
    let auth = AuthModel(services: services)
    return NavigationStack {
        AssignmentDetailView(assignmentID: "example")
            .environment(services)
            .environment(auth)
    }
}
