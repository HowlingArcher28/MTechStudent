//
//  Game.swift
//  GamesTrackerProject
//

import Foundation
import SwiftData

enum InGameSortMode: String, Codable, CaseIterable, Identifiable {
    case highestFirst
    case lowestFirst
    var id: String { rawValue }

    var title: String {
        switch self {
        case .highestFirst: return "Sort by Highest"
        case .lowestFirst: return "Sort by Lowest"
        }
    }
}

enum WinRule: String, Codable, CaseIterable, Identifiable {
    case highestScoreWins
    case lowestScoreWins
    var id: String { rawValue }

    var title: String {
        switch self {
        case .highestScoreWins: return "Highest Score Wins"
        case .lowestScoreWins: return "Lowest Score Wins"
        }
    }
}

@Model
final class Game {
    @Attribute(.unique) var id: UUID
    var title: String
    var createdAt: Date
    var inGameSortMode: InGameSortMode
    var winRule: WinRule
    var orderIndex: Int
    @Relationship(deleteRule: .cascade, inverse: \Player.game) var players: [Player]

    init(
        id: UUID = UUID(),
        title: String,
        createdAt: Date = .now,
        inGameSortMode: InGameSortMode,
        winRule: WinRule,
        orderIndex: Int = 0,
        players: [Player] = []
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.inGameSortMode = inGameSortMode
        self.winRule = winRule
        self.orderIndex = orderIndex
        self.players = players
    }
}
