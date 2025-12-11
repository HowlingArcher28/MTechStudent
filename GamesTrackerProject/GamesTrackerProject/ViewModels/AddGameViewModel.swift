//
//  AddGameViewModel.swift
//  GamesTrackerProject
//

import Foundation
import Combine
import SwiftUI
import SwiftData

final class AddGameViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var inGameSortMode: InGameSortMode = .highestFirst
    @Published var winRule: WinRule = .highestScoreWins
    @Published var tempPlayers: [Player] = []

    func buildGame() -> Game {
        let game = Game(
            title: title.isEmpty ? "New Game" : title,
            inGameSortMode: inGameSortMode,
            winRule: winRule
        )
        for (idx, player) in tempPlayers.enumerated() {
            player.orderIndex = idx
            player.game = game
        }
        game.players = tempPlayers
        return game
    }

    func addTempPlayer(name: String, icon: String, score: Int) {
        let p = Player(name: name, icon: icon, score: score, orderIndex: tempPlayers.count, game: nil)
        tempPlayers.append(p)
    }

    func deleteTempPlayers(at offsets: IndexSet) {
        tempPlayers.remove(atOffsets: offsets)
    }

    func moveTempPlayers(from source: IndexSet, to destination: Int) {
        tempPlayers.move(fromOffsets: source, toOffset: destination)
        for (idx, player) in tempPlayers.enumerated() {
            player.orderIndex = idx
        }
    }
}
