import Foundation
import SwiftUI

@MainActor
final class LocalEventStore: ObservableObject {
    @Published private(set) var events: [Event] = []

    init() {
        // Seed with a couple example events
        let now = Date()
        let cal = Calendar.current
        if let todayStart = cal.date(bySettingHour: 9, minute: 0, second: 0, of: now),
           let todayEnd = cal.date(bySettingHour: 10, minute: 0, second: 0, of: now) {
            events.append(Event(title: "Morning Meeting", startDate: todayStart, endDate: todayEnd, notes: "Discuss roadmap", color: .purple))
        }
        if let tomorrow = cal.date(byAdding: .day, value: 1, to: now),
           let start = cal.date(bySettingHour: 13, minute: 0, second: 0, of: tomorrow),
           let end = cal.date(bySettingHour: 14, minute: 0, second: 0, of: tomorrow) {
            events.append(Event(title: "Lunch with Sam", startDate: start, endDate: end, notes: nil, color: .orange))
        }
    }

    func events(on day: Date, calendar: Calendar = .current) -> [Event] {
        events.filter { ev in
            calendar.isDate(day, inSameDayAs: ev.startDate) || calendar.isDate(day, inSameDayAs: ev.endDate) ||
            (ev.startDate ... ev.endDate).contains(day)
        }
        .sorted { $0.startDate < $1.startDate }
    }

    func add(_ event: Event) {
        events.append(event)
    }

    func update(_ event: Event) {
        guard let idx = events.firstIndex(where: { $0.id == event.id }) else { return }
        events[idx] = event
    }

    func delete(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
}
