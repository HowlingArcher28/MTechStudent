// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var themeStore: ThemeStore

    var body: some View {
        Form {
            Section(header: Text("Theme").foregroundStyle(themeStore.secondaryText)) {
                Picker("Appearance", selection: $themeStore.selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        HStack {
                            ColorSwatch(color: theme.accentColor)
                            Text(theme.displayName)
                                .foregroundStyle(themeStore.primaryText)
                        }
                        .tag(theme)
                    }
                }
                .pickerStyle(.navigationLink)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Live Preview")
                        .font(.caption)
                        .foregroundStyle(themeStore.secondaryText)

                    HStack {
                        Label("Accent", systemImage: "paintbrush.pointed.fill")
                        Spacer()
                        Circle().fill(themeStore.accentColor)
                            .frame(width: 24, height: 24)
                    }
                    .padding(10)
                    .background(themeStore.secondaryBackground, in: RoundedRectangle(cornerRadius: 8))
                }
                .listRowBackground(themeStore.listRowBackground)
            }

            Section(footer: Text("Theme selection is saved and applied across the app.")
                .foregroundStyle(themeStore.secondaryText)) {
                EmptyView()
            }
        }
        .scrollContentBackground(.hidden)
        .background(themeStore.background)
        .listRowBackground(themeStore.listRowBackground)
        .tint(themeStore.accentColor)
    }
}

private struct ColorSwatch: View {
    let color: Color
    var body: some View {
        Circle().fill(color).frame(width: 12, height: 12)
    }
}
