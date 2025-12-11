//
//  AddPlayerView.swift
//  GamesTrackerProject
//

import SwiftUI

struct AddPlayerView: View {
    struct ExistingPlayerDisplay: Identifiable {
        let id: UUID
        let name: String
        let icon: String
        let score: Int
    }

    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var icon: String = "person.fill"
    @State private var startingScore: Int = 0

    var existingPlayers: [ExistingPlayerDisplay]
    var onAdd: (String, String, Int) -> Void

    private let iconOptions: [String] = [
        "person.fill", "gamecontroller.fill", "flame.fill", "bolt.fill",
        "target", "star.fill", "crown.fill", "trophy.fill",
        "die.face.5.fill", "puzzlepiece.fill", "flag.fill", "leaf.fill"
    ]

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 12), count: 4)

    var body: some View {
        Form {
            Section {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.blue.opacity(0.12))
                        Image(systemName: icon)
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(.blue)
                    }
                    .frame(width: 56, height: 56)
                    .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Player name", text: $name)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                        Stepper(value: $startingScore, in: -10_000...10_000, step: 1) {
                            HStack {
                                Text("Starting Score")
                                Spacer()
                                Text("\(startingScore)")
                                    .monospacedDigit()
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            } header: {
                Text("New Player")
            } footer: {
                if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text("Enter a name to enable Add.")
                }
            }

            Section("Icon") {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(iconOptions, id: \.self) { option in
                        Button {
                            icon = option
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(icon == option ? Color.blue.opacity(0.15) : Color.secondary.opacity(0.08))
                                Image(systemName: option)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(icon == option ? .blue : .primary)
                            }
                            .frame(height: 44)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(option)
                        .accessibilityAddTraits(icon == option ? .isSelected : [])
                    }
                }
                .padding(.vertical, 4)
            }

            if !existingPlayers.isEmpty {
                Section("Existing Players") {
                    ForEach(existingPlayers) { p in
                        HStack(spacing: 12) {
                            Image(systemName: p.icon)
                                .foregroundStyle(.secondary)
                            Text(p.name)
                            Spacer()
                            Text("\(p.score)")
                                .monospacedDigit()
                                .foregroundStyle(.secondary)
                        }
                        .contentShape(Rectangle())
                    }
                }
            }
        }
        .navigationTitle("Add Player")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    onAdd(name, icon, startingScore)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPlayerView(
            existingPlayers: [
                .init(id: UUID(), name: "Alex", icon: "trophy.fill", score: 12),
                .init(id: UUID(), name: "Sam", icon: "gamecontroller.fill", score: -3)
            ],
            onAdd: { _,_,_ in }
        )
    }
}

