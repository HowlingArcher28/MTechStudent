/*
 SettingsView.swift
 
 Overview:
 A simple settings screen. Currently displays the selected cohort for calendar
 data and can be expanded with additional configuration options.
*/

import SwiftUI

struct SettingsView: View {
    @Environment(AppModel.self) private var model

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
                labeledRow(title: "Cohort", value: "fall2025")
            } header: {
                Text("Calendar")
            }
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

