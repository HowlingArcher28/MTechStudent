//
//  FunnyPost.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//


import Foundation

struct FunnyPost: Identifiable, Hashable, Codable {
    let id: UUID
    var author: String
    var text: String
    var timestamp: Date
    var reactions: [Reaction: Int]
    var comments: [Comment]

    init(
        id: UUID = UUID(),
        author: String,
        text: String,
        timestamp: Date = .now,
        reactions: [Reaction: Int] = [
            .lol: 0,        // Upvote
            .heh: 0,        // Insightful
            .groan: 0,      // Needs Work
            .bug: 0,        // Bug
            .question: 0    // Question
        ],
        comments: [Comment] = []
    ) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
        self.reactions = reactions
        self.comments = comments
    }
}
