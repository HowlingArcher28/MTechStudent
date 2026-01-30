import Foundation
import SwiftUI

struct Card: Identifiable, Equatable {
    let id: UUID
    var description: String
    var date: Date
    var backgroundColor: Color
    var imageData: Data?

    init(id: UUID = UUID(), description: String = "", date: Date = Date(), backgroundColor: Color = .blue, imageData: Data? = nil) {
        self.id = id
        self.description = description
        self.date = date
        self.backgroundColor = backgroundColor
        self.imageData = imageData
    }
}
