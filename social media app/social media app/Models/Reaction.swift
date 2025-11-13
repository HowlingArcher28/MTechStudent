//
//  Reaction.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//


import Foundation

enum Reaction: String, CaseIterable, Hashable, Codable {
    // Engineer-oriented reactions
    case lol = "👍"       // Upvote
    case heh = "💡"       // Insightful
    case groan = "🛠"     // Needs Work
    case bug = "🐞"       // Bug
    case question = "❓"  // Question

    var label: String {
        switch self {
        case .lol: return "Upvote"
        case .heh: return "Insightful"
        case .groan: return "Needs Work"
        case .bug: return "Bug"
        case .question: return "Question"
        }
    }

    var emoji: String { rawValue }
}
