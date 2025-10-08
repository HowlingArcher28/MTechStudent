import Foundation

struct Quote: Identifiable, Equatable {
    let id: UUID
    var text: String
    var author: String
    var dateAdded: Date

    init(id: UUID = UUID(), text: String, author: String, dateAdded: Date = Date()) {
        self.id = id
        self.text = text
        self.author = author
        self.dateAdded = dateAdded
    }
}
