import Foundation
import SwiftUI

struct Event: Identifiable, Equatable {
    let id: UUID
    var title: String
    var startDate: Date
    var endDate: Date
    var notes: String?
    var color: Color

    init(id: UUID = UUID(),
         title: String,
         startDate: Date,
         endDate: Date,
         notes: String? = nil,
         color: Color = .blue) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.color = color
    }

    var isAllDay: Bool {
        Calendar.current.isDate(startDate, inSameDayAs: endDate) &&
        Calendar.current.component(.hour, from: startDate) == 0 &&
        Calendar.current.component(.minute, from: startDate) == 0 &&
        Calendar.current.component(.hour, from: endDate) == 0 &&
        Calendar.current.component(.minute, from: endDate) == 0
    }
}
