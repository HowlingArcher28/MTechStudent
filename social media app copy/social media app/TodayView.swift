import SwiftUI

struct TodayView: View {
    @Environment(AuthModel.self) private var auth
    @Environment(ServicesModel.self) private var services
    @State private var entry: APIClient.CalendarEntryResponseDTO?
    @State private var error: String?

    private func loadToday() async {
        do {
            entry = try await services.api.calendarToday(cohort: services.cohort)
            error = nil
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }

    var body: some View {
        Group {
            if let error {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Retry") {
                        Task { await loadToday() }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if entry == nil {
                ProgressView("Loading Today…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let entry {
                Group {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Date: \(String(describing: entry.date))")
                            .font(.headline)
                        if entry.holiday {
                            Text("Holiday")
                                .foregroundStyle(.secondary)
                        } else {
                            if let lesson = entry.lessonName { Text("Lesson: \(lesson)") }
                            if let objective = entry.mainObjective { Text("Objective: \(objective)") }
                            let dueCount = entry.assignmentsDue?.count ?? 0
                            Text("Assignments Due: \(dueCount)")
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        .refreshable {
            await loadToday()
        }
        .task {
            await loadToday()
        }
    }
}

#Preview {
    TodayView()
        .environment(AuthModel())
        .environment(ServicesModel())
}
