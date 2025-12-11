//
//  AddGameView.swift
//  GamesTrackerProject
//

import SwiftUI
import SwiftData

struct AddGameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddGameViewModel()
    var onSave: (Game) -> Void

    @State private var showAddPlayer = false

    var body: some View {
        Form {
            Section("Game") {
                TextField("Title", text: $viewModel.title)
                Picker("In-Game Sort", selection: $viewModel.inGameSortMode) {
                    ForEach(InGameSortMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                Picker("Win Rule", selection: $viewModel.winRule) {
                    ForEach(WinRule.allCases) { rule in
                        Text(rule.title).tag(rule)
                    }
                }
            }

            Section {
                if viewModel.tempPlayers.isEmpty {
                    ContentUnavailableView("No Players", systemImage: "person.2", description: Text("Add players before starting the game."))
                        .frame(maxWidth: .infinity)
                } else {
                    List {
                        ForEach(viewModel.tempPlayers) { player in
                            HStack {
                                Image(systemName: player.icon)
                                Text(player.name)
                                Spacer()
                                Text("\(player.score)")
                                    .monospacedDigit()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTempPlayers)
                        .onMove(perform: viewModel.moveTempPlayers)
                    }
                    .frame(minHeight: 150, maxHeight: 250)
                }
                Button {
                    showAddPlayer = true
                } label: {
                    Label("Add Player", systemImage: "plus.circle.fill")
                }
            } header: {
                HStack {
                    Text("Players")
                    Spacer()
                    EditButton()
                }
            }
        }
        .navigationTitle("New Game")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let game = viewModel.buildGame()
                    onSave(game)
                    dismiss()
                }
                .disabled(viewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && viewModel.tempPlayers.isEmpty)
            }
        }
        .sheet(isPresented: $showAddPlayer) {
            NavigationStack {
                AddPlayerView(
                    existingPlayers: viewModel.tempPlayers.map {
                        AddPlayerView.ExistingPlayerDisplay(
                            id: $0.id,
                            name: $0.name,
                            icon: $0.icon,
                            score: $0.score
                        )
                    },
                    onAdd: { name, icon, score in
                        viewModel.addTempPlayer(name: name, icon: icon, score: score)
                    }
                )
            }
        }
    }
}
