//
//  Player.swift
//  GamesTrackerProject
//

import Foundation
import SwiftData

@Model
final class Player {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var score: Int
    var orderIndex: Int
    @Relationship var game: Game?

    init(
        id: UUID = UUID(),
        name: String,
        icon: String = "person.fill",
        score: Int = 0,
        orderIndex: Int = 0,
        game: Game? = nil
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.score = score
        self.orderIndex = orderIndex
        self.game = game
    }
}
