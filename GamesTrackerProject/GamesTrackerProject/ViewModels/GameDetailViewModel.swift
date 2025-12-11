//
//  GameDetailViewModel.swift
//  GamesTrackerProject
//

import Foundation
import SwiftUI
import SwiftData
import Combine

final class GameDetailViewModel: ObservableObject {
    @Published var isEditing: Bool = false

    func sortedPlayers(for game: Game, isEditing: Bool) -> [Player] {
        if isEditing {
            return game.players.sorted { $0.orderIndex < $1.orderIndex }
        }
        switch game.inGameSortMode {
        case .highestFirst:
            return game.players.sorted { lhs, rhs in
                if lhs.score == rhs.score { return lhs.name < rhs.name }
                return lhs.score > rhs.score
            }
        case .lowestFirst:
            return game.players.sorted { lhs, rhs in
                if lhs.score == rhs.score { return lhs.name < rhs.name }
                return lhs.score < rhs.score
            }
        }
    }

    func increment(_ player: Player, by delta: Int, context: ModelContext) {
        player.score += delta
        try? context.save()
    }

    func addPlayer(to game: Game, name: String, icon: String, startingScore: Int, context: ModelContext) {
        let newIndex = (game.players.map { $0.orderIndex }.max() ?? -1) + 1
        let p = Player(name: name, icon: icon, score: startingScore, orderIndex: newIndex, game: game)
        game.players.append(p)
        try? context.save()
    }

    func deletePlayers(at offsets: IndexSet, from players: [Player], context: ModelContext) {
        offsets.map { players[$0] }.forEach { p in
            context.delete(p)
        }
        try? context.save()
    }

    func movePlayers(from source: IndexSet, to destination: Int, players: [Player], context: ModelContext) {
        var mutable = players
        mutable.move(fromOffsets: source, toOffset: destination)
        for (idx, p) in mutable.enumerated() {
            p.orderIndex = idx
        }
        try? context.save()
    }
}
