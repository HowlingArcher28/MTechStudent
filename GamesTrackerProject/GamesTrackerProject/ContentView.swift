//
//  ContentView.swift
//  GamesTrackerProject
//
//  Created by Zachary Jensen on 12/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scenePhase
    @Query(sort: [SortDescriptor(\Game.orderIndex), SortDescriptor(\Game.createdAt)]) private var games: [Game]
    @StateObject private var viewModel = GamesListViewModel()
    @State private var showAddGame = false
    @Namespace private var rowNamespace

    private func playerChips(for game: Game) -> some View {
        let players = game.players.sorted { $0.orderIndex < $1.orderIndex }
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(players) { p in
                    HStack(spacing: 4) {
                        Text(p.name)
                            .lineLimit(1)
                        Text("\(p.score)")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(Color.blue.opacity(0.10))
                    )
                    .accessibilityLabel("\(p.name) \(p.score)")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        GameDetailView(game: game, namespace: rowNamespace)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading) {
                                    Text(game.title)
                                        .font(.headline)
                                    if let status = viewModel.winningStatusText(for: game) {
                                        Text(status)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                            }
                            // All players' scores
                            playerChips(for: game)
                        }
                    }
                    .contentShape(Rectangle())
                    .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                            removal: .move(edge: .leading).combined(with: .opacity)))
                }
                .onDelete { indexSet in
                    withAnimation {
                        viewModel.deleteGames(at: indexSet, from: games, context: context)
                    }
                }
                .onMove { from, to in
                    withAnimation {
                        viewModel.moveGames(from: from, to: to, games: games, context: context)
                    }
                }
            }
            .animation(.default, value: games.map { $0.id })
            .navigationTitle("Games")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddGame = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Game")
                }
            }
            .sheet(isPresented: $showAddGame) {
                NavigationStack {
                    AddGameView { newGame in
                        withAnimation(.spring) {
                            context.insert(newGame)
                            viewModel.assignOrderIndexOnInsert(game: newGame, existing: games, context: context)
                        }
                    }
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            // Safety net: persist any pending changes when app goes inactive/background.
            if newPhase == .inactive || newPhase == .background {
                do {
                    try context.save()
                } catch {
                    assertionFailure("Failed to save model context on scene phase change: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Game.self, Player.self], inMemory: true)
}
