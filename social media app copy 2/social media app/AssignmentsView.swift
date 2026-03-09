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
                        if let dueOn = assignment.dueOn,
                           let dueDate = ISO8601DateFormatter().date(from: dueOn) {
                            Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.footnote)
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
        await services.loadAll(cohort: cohort)
        assignments = services.allAssignments
    }
}
