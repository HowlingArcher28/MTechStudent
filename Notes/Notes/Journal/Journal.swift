import Foundation
import SwiftData

@Model
class Journal {
    var name: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Note.journal)
    var notes: [Note] = []

    init(name: String, createdAt: Date = Date()) {
        self.name = name
        self.createdAt = createdAt
    }
}
