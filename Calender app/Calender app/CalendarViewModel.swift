import Foundation
import SwiftUI

struct CalendarDay: Identifiable, Hashable {
    var id: Date { date }
    let date: Date
    let isCurrentMonth: Bool
    let isToday: Bool
}

@MainActor
final class CalendarViewModel: ObservableObject {
    @Published var displayedMonth: Date
    @Published var selectedDate: Date?

    private let calendar: Calendar

    init(calendar: Calendar = .current, initialDate: Date = Date()) {
        self.calendar = calendar
        self.displayedMonth = calendar.startOfMonth(for: initialDate)
        self.selectedDate = initialDate
    }

    var monthTitle: String {
        let fmt = DateFormatter()
        fmt.calendar = calendar
        fmt.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return fmt.string(from: displayedMonth)
    }

    var weekdaySymbols: [String] {
        // Locale-aware first weekday
        let symbols = DateFormatter().shortStandaloneWeekdaySymbols ?? Calendar.current.shortWeekdaySymbols
        let first = calendar.firstWeekday - 1
        return Array(symbols[first...] + symbols[..<first])
    }

    var days: [CalendarDay] {
        let startOfMonth = calendar.startOfMonth(for: displayedMonth)
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        let numberOfDaysInMonth = range.count

        let firstWeekdayOfMonth = calendar.component(.weekday, from: startOfMonth)
        let leadingEmptyDays = (firstWeekdayOfMonth - calendar.firstWeekday + 7) % 7

        var grid: [CalendarDay] = []

        // Leading days from previous month
        if leadingEmptyDays > 0 {
            let prevMonth = calendar.date(byAdding: .month, value: -1, to: startOfMonth)!
            let prevRange = calendar.range(of: .day, in: .month, for: prevMonth)!
            let startDay = prevRange.count - leadingEmptyDays + 1
            for d in startDay...prevRange.count {
                let date = calendar.date(bySetting: .day, value: d, of: prevMonth)!
                grid.append(CalendarDay(date: date,
                                        isCurrentMonth: false,
                                        isToday: calendar.isDateInToday(date)))
            }
        }

        // Current month days
        for d in 1...numberOfDaysInMonth {
            let date = calendar.date(bySetting: .day, value: d, of: startOfMonth)!
            grid.append(CalendarDay(date: date,
                                    isCurrentMonth: true,
                                    isToday: calendar.isDateInToday(date)))
        }

        // Trailing days to fill 6 rows (42 cells)
        while grid.count % 7 != 0 || grid.count < 42 {
            let lastDate = grid.last!.date
            let date = calendar.date(byAdding: .day, value: 1, to: lastDate)!
            grid.append(CalendarDay(date: date,
                                    isCurrentMonth: false,
                                    isToday: calendar.isDateInToday(date)))
        }

        return grid
    }

    func goToPreviousMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
    }

    func goToNextMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
    }

    func goToToday() {
        let today = Date()
        displayedMonth = calendar.startOfMonth(for: today)
        selectedDate = today
    }
}

private extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let comps = dateComponents([.year, .month], from: date)
        return self.date(from: comps)!
    }
}
