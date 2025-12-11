//
//  GameDetailView.swift
//  GamesTrackerProject
//

import SwiftUI
import SwiftData

struct GameDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.editMode) private var editMode
    @ObservedObject private var viewModel = GameDetailViewModel()

    @State private var showAddPlayer = false

    let game: Game
    let namespace: Namespace.ID

    var body: some View {
        let isEditing = (editMode?.wrappedValue.isEditing ?? false)
        let players = viewModel.sortedPlayers(for: game, isEditing: isEditing)

        List {
            ForEach(players) { player in
                PlayerRowView(player: player, onChange: { delta in
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                        viewModel.increment(player, by: delta, context: context)
                    }
                })
                .transition(.opacity.combined(with: .scale(scale: 0.98)))
            }
            .onDelete { indexSet in
                withAnimation {
                    viewModel.deletePlayers(at: indexSet, from: players, context: context)
                }
            }
            .onMove { from, to in
                withAnimation {
                    viewModel.movePlayers(from: from, to: to, players: players, context: context)
                }
            }
        }
        .animation(.default, value: players.map { $0.id })
        .navigationTitle(game.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddPlayer = true
                } label: {
                    Image(systemName: "person.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showAddPlayer) {
            NavigationStack {
                AddPlayerView(
                    existingPlayers: game.players.map {
                        AddPlayerView.ExistingPlayerDisplay(
                            id: $0.id,
                            name: $0.name,
                            icon: $0.icon,
                            score: $0.score
                        )
                    },
                    onAdd: { name, icon, score in
                        withAnimation(.spring) {
                            viewModel.addPlayer(to: game, name: name, icon: icon, startingScore: score, context: context)
                        }
                    }
                )
            }
        }
    }
}

