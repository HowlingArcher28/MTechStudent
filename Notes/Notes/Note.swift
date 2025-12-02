import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var body: String
    var createdAt: Date

    init(title: String, body: String, createdAt: Date = Date()) {
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}
