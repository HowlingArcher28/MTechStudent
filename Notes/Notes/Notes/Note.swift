import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var body: String
    var createdAt: Date

    var journal: Journal?

    init(title: String, body: String, createdAt: Date = Date(), journal: Journal? = nil) {
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.journal = journal
    }
}
