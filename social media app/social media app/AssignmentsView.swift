import SwiftUI
import Foundation

struct AssignmentsView: View {

    @EnvironmentObject var services: ServicesModel
    let cohort: String

    @State private var assignments: [AssignmentResponseDTO] = []
    @State private var alertMessage: AlertMessage?

    var body: some View {
        VStack {
            if assignments.isEmpty {
                ProgressView()
            } else {
                List(assignments, id: \.id) { assignment in
                    VStack(alignment: .leading) {
                        Text(assignment.name)
                            .font(.headline)
                        if let dueDate = ISO8601DateFormatter().date(from: assignment.dueOn) {
                            Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .task {
            await loadAssignments()
        }
        .alert(item: $alertMessage) { alert in
            Alert(
                title: Text("Error"),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Assignments")
    }

    @MainActor
    private func loadAssignments() async {
        do {
            // Call directly on the ServicesModel instance
            assignments = try await services.fetchAssignments(cohort: cohort)
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
}
