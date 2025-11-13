// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: AppModel

    private var lastSavedText: String {
        if let date = lastSavedDate() {
            return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
        } else {
            return "Never"
        }
    }

    var body: some View {
        Form {
            Section {
                labeledRow(title: "Posts", value: "\(model.posts.count)")
                labeledRow(title: "Comments", value: "\(model.posts.flatMap(\.comments).count)")
                labeledRow(title: "Last Saved", value: lastSavedText)
            } header: {
                Text("Status")
            }

            // All JSON saving/data controls encapsulated in their own view
            PersistenceControlsView()
        }
        .navigationTitle("Settings")
    }

    // MARK: - Simple labeled row helper
    @ViewBuilder
    private func labeledRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).foregroundStyle(.secondary)
        }
    }

    // MARK: - Last saved timestamp helper (read-only)
    private func lastSavedDate() -> Date? {
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = dir.appendingPathComponent("AppState.json")
            let attrs = try FileManager.default.attributesOfItem(atPath: url.path)
            return attrs[.modificationDate] as? Date
        } catch {
            return nil
        }
    }
}
