//
//  GamesListViewModel.swift
//  GamesTrackerProject
//

import Foundation
import SwiftData
import Combine
import SwiftUI

final class GamesListViewModel: ObservableObject {

    func winningStatusText(for game: Game) -> String? {
        guard let leader = currentLeader(in: game) else { return nil }
        switch game.winRule {
        case .highestScoreWins:
            return "Winning: \(leader.name) (\(leader.score))"
        case .lowestScoreWins:
            return "Leading: \(leader.name) (\(leader.score))"
        }
    }

    func currentLeader(in game: Game) -> Player? {
        guard !game.players.isEmpty else { return nil }
        switch game.winRule {
        case .highestScoreWins:
            return game.players.max(by: { $0.score < $1.score })
        case .lowestScoreWins:
            return game.players.min(by: { $0.score < $1.score })
        }
    }

    func assignOrderIndexOnInsert(game: Game, existing: [Game], context: ModelContext) {
        let maxIndex = existing.map { $0.orderIndex }.max() ?? -1
        game.orderIndex = maxIndex + 1
        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save after assigning order index: \(error)")
        }
    }

    func deleteGames(at offsets: IndexSet, from games: [Game], context: ModelContext) {
        offsets.map { games[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save after deleting games: \(error)")
        }
    }

    func moveGames(from source: IndexSet, to destination: Int, games: [Game], context: ModelContext) {
        var mutable = games
        mutable.move(fromOffsets: source, toOffset: destination)
        for (idx, game) in mutable.enumerated() {
            game.orderIndex = idx
        }
        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save after moving games: \(error)")
        }
    }
}
