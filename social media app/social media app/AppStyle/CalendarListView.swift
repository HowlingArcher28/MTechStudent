import SwiftUI

struct CalendarListView: View {

    @EnvironmentObject var services: ServicesModel
    let cohort: String

    var body: some View {
        VStack {
            if services.allAssignments.isEmpty {
                ProgressView("Loading assignments...")
                    .task {
                        await services.loadAll(cohort: cohort)
                    }
            } else {
                List(services.allAssignments, id: \.id) { assignment in
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
        .alert(item: $services.alertMessage) { alert in
            Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Assignments")
    }
}
