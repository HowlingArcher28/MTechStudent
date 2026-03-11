/*
 PersistenceControlsView.swift
 
 Overview:
 A small settings section offering explicit Save and Clear actions for the app's
 persisted state. Demonstrates local JSON save/clear operations and presents
 errors with alerts and confirmation dialogs.
*/

import SwiftUI

struct PersistenceControlsView: View {
    @Environment(AppModel.self) var model

    @State private var showError = false
    @State private var errorMessage: String?
    @State private var showingClearConfirm = false

    @State private var saveBounce = 0
    @State private var clearBounce = 0

    var body: some View {
        Section {
            Button {
                saveBounce &+= 1
                do {
                    try saveNow()
                } catch {
                    errorMessage = "Save failed: \(error.localizedDescription)"
                    showError = true
                }
            } label: {
                Label("Save Now", systemImage: "square.and.arrow.down")
                    .symbolEffect(.bounce, value: saveBounce)
            }
            .sensoryFeedback(.success, trigger: saveBounce)
            .buttonStyle(PressFeedbackButtonStyle())

            Button(role: .destructive) {
                clearBounce &+= 1
                showingClearConfirm = true
            } label: {
                Label("Clear Saved Data", systemImage: "trash")
                    .symbolEffect(.bounce, value: clearBounce)
            }
            .sensoryFeedback(.warning, trigger: clearBounce)
            .buttonStyle(PressFeedbackButtonStyle())
        } footer: {
            Text("Save writes the current state to disk. Clear removes saved state and clears posts.")
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { showError = false }
        } message: {
            Text(errorMessage ?? "")
        }
        .confirmationDialog("Clear all saved data?", isPresented: $showingClearConfirm, titleVisibility: .visible) {
            Button("Clear Data", role: .destructive) {
                do {
                    try clearAllData()
                } catch {
                    errorMessage = "Clear failed: \(error.localizedDescription)"
                    showError = true
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This removes saved state from this device and clears in-memory posts. This action cannot be undone.")
        }
    }

    private func stateURL() throws -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw CocoaError(.fileNoSuchFile)
        }
        return dir.appendingPathComponent("AppState.json")
    }

    private func saveNow() throws {
        struct AppState: Codable {
            var profile: UserProfile
            var currentUser: String
        }
        let state = AppState(profile: model.profile, currentUser: model.currentUser)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(state)
        let url = try stateURL()
        try data.write(to: url, options: .atomic)
    }

    private func clearAllData() throws {
        let url = try stateURL()
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }
}

private struct PressFeedbackButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}
