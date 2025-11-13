// Comment.swift
import Foundation

struct Comment: Identifiable, Hashable, Codable {
    let id: UUID
    var author: String
    var text: String
    var timestamp: Date

    init(
        id: UUID = UUID(),
        author: String,
        text: String,
        timestamp: Date = .now
    ) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
    }
}
