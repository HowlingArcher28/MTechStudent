import SwiftUI

struct AssignmentsView: View {
    @Environment(AuthModel.self) private var auth
    @Environment(ServicesModel.self) private var services
    @State private var assignments: [APIClient.AssignmentResponseDTO] = []
    @State private var error: String?

    var body: some View {
        Group {
            if let error {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                    Text(error)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if assignments.isEmpty {
                ProgressView("Loading Assignments…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(assignments) { item in
                    HStack {
                        Image(systemName: "checklist")
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text("Due: \(String(describing: item.dueOn))")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .task {
            do {
                print("[AssignmentsView] Fetching assignments for cohort:", services.cohort)
                assignments = try await services.api.assignmentsAll(cohort: services.cohort)
                print("[AssignmentsView] Loaded assignments:", assignments.count)
            } catch {
                print("[AssignmentsView] Assignments fetch failed:", error)
                self.error = (error as NSError).localizedDescription
            }
        }
    }
}

#Preview {
    // Construct a ServicesModel using API info for previews.
    // If your project exposes an API config type (e.g., APIInfo.shared), replace the initializer below accordingly.
    let services = ServicesModel() // TODO: If available, initialize with API info, e.g., ServicesModel(apiInfo: APIInfo.shared)
    let auth = AuthModel(services: services)
    return NavigationStack {
        AssignmentsView()
            .environment(auth)
            .environment(services)
    }
}
