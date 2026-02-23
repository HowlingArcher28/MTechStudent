import SwiftUI

struct CalendarListView: View {
    @Environment(ServicesModel.self) private var services
    @State private var days: [APIClient.CalendarEntryResponseDTO] = []
    @State private var error: String?

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 7)
    }

    var body: some View {
        Group {
            if let error {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                    Text(error)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if days.isEmpty {
                ProgressView("Loading Calendar…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(days, id: \.date) { day in
                            NavigationLink {
                                CalendarDayDetailView(day: day)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .firstTextBaseline) {
                                        Text(dayNumber(from: day.date))
                                            .font(.title2.bold())
                                        if day.holiday {
                                            Image(systemName: "sparkles")
                                                .foregroundStyle(.yellow)
                                        }
                                        Spacer(minLength: 0)
                                    }

                                    if let lesson = day.lessonName, !lesson.isEmpty {
                                        Text(lesson)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.8)
                                    }

                                    HStack(spacing: 6) {
                                        if let due = day.assignmentsDue, !due.isEmpty {
                                            Label("\(due.count)", systemImage: "tray.full")
                                                .labelStyle(.iconOnly)
                                                .font(.footnote)
                                                .padding(4)
                                                .background(Color.blue.opacity(0.15), in: Capsule())
                                                .foregroundStyle(.blue)
                                                .accessibilityLabel("Assignments due: \(due.count)")
                                        }
                                        if let newA = day.newAssignments, !newA.isEmpty {
                                            Label("\(newA.count)", systemImage: "plus.circle.fill")
                                                .labelStyle(.iconOnly)
                                                .font(.footnote)
                                                .padding(4)
                                                .background(Color.green.opacity(0.15), in: Capsule())
                                                .foregroundStyle(.green)
                                                .accessibilityLabel("New assignments: \(newA.count)")
                                        }
                                        Spacer(minLength: 0)
                                    }
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            (day.holiday ? Color.yellow.opacity(0.15) : ((day.assignmentsDue?.isEmpty == false || day.newAssignments?.isEmpty == false) ? Color.blue.opacity(0.08) : Color.clear))
                                        )
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(monthTitle())
        .task {
            do {
                days = try await services.api.calendarAll(cohort: services.cohort)
            } catch {
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("[CalendarListView] Decoding error: keyNotFound ->", key.stringValue, "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .valueNotFound(let type, let context):
                        print("[CalendarListView] Decoding error: valueNotFound ->", String(describing: type), "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .typeMismatch(let type, let context):
                        print("[CalendarListView] Decoding error: typeMismatch ->", String(describing: type), "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .dataCorrupted(let context):
                        print("[CalendarListView] Decoding error: dataCorrupted ->", context.debugDescription, "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    @unknown default:
                        print("[CalendarListView] Decoding error: unknown ->", String(describing: decodingError))
                    }
                } else {
                    print("[CalendarListView] Error loading calendar:", error)
                }
                self.error = (error as NSError).localizedDescription
            }
        }
        .refreshable {
            do {
                days = try await services.api.calendarAll(cohort: services.cohort)
                error = nil
            } catch {
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("[CalendarListView] Decoding error (refresh): keyNotFound ->", key.stringValue, "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .valueNotFound(let type, let context):
                        print("[CalendarListView] Decoding error (refresh): valueNotFound ->", String(describing: type), "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .typeMismatch(let type, let context):
                        print("[CalendarListView] Decoding error (refresh): typeMismatch ->", String(describing: type), "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    case .dataCorrupted(let context):
                        print("[CalendarListView] Decoding error (refresh): dataCorrupted ->", context.debugDescription, "path:", context.codingPath.map { $0.stringValue }.joined(separator: "."))
                    @unknown default:
                        print("[CalendarListView] Decoding error (refresh): unknown ->", String(describing: decodingError))
                    }
                } else {
                    print("[CalendarListView] Error loading calendar (refresh):", error)
                }
                self.error = (error as NSError).localizedDescription
            }
        }
    }

    private func dayNumber(from isoDate: String) -> String {
        // try to parse ISO8601 date string and return day number
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let dayFormatter = DateFormatter()
            dayFormatter.locale = Locale.current
            dayFormatter.dateFormat = "d"
            return dayFormatter.string(from: date)
        }
        // fallback: try a simpler parse if ISO8601DateFormatter fails (e.g. if only YYYY-MM-DD)
        let simpleFormatter = DateFormatter()
        simpleFormatter.locale = Locale.current
        simpleFormatter.dateFormat = "yyyy-MM-dd"
        if let date = simpleFormatter.date(from: isoDate) {
            let dayFormatter = DateFormatter()
            dayFormatter.locale = Locale.current
            dayFormatter.dateFormat = "d"
            return dayFormatter.string(from: date)
        }
        // fallback return input string if parsing fails
        return isoDate
    }

    private func monthTitle() -> String {
        guard let first = days.first else {
            return "Calendar"
        }
        let formatter = ISO8601DateFormatter()
        var date: Date?
        if let d = formatter.date(from: first.date) {
            date = d
        } else {
            let simpleFormatter = DateFormatter()
            simpleFormatter.dateFormat = "yyyy-MM-dd"
            date = simpleFormatter.date(from: first.date)
        }
        guard let validDate = date else {
            return "Calendar"
        }
        let monthYearFormatter = DateFormatter()
        monthYearFormatter.locale = Locale.current
        monthYearFormatter.dateFormat = "LLLL yyyy"
        return monthYearFormatter.string(from: validDate)
    }
    
    private func uniqueID(for day: APIClient.CalendarEntryResponseDTO) -> String {
        day.id ?? day.date
    }
}

#Preview {
    NavigationStack {
        CalendarListView()
            .environment(ServicesModel())
    }
}
struct CalendarDayDetailView: View {
    let day: APIClient.CalendarEntryResponseDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(day.date)
                    .font(.title2.bold())
                if day.holiday {
                    Label("Holiday", systemImage: "sparkles")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.yellow)
                        .padding(6)
                        .background(.yellow.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
                }
            }
            
            if let lesson = day.lessonName {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lesson")
                        .font(.headline)
                    Text(lesson)
                }
            }
            
            if let objective = day.mainObjective {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Main Objective")
                        .font(.headline)
                    Text(objective)
                }
            }
            
            if let assignmentsDue = day.assignmentsDue, !assignmentsDue.isEmpty {
                Text("Assignments Due: \(assignmentsDue.count)")
            }
            
            if let newAssignments = day.newAssignments, !newAssignments.isEmpty {
                Text("New Assignments: \(newAssignments.count)")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

