// ThemeStore.swift
import SwiftUI
import Combine

final class ThemeStore: ObservableObject {
    @Published var selectedTheme: AppTheme {
        didSet { save() }
    }

    init() {
        if let raw = UserDefaults.standard.string(forKey: Self.key),
           let theme = AppTheme(rawValue: raw) {
            self.selectedTheme = theme
        } else {
            self.selectedTheme = .system
        }
    }

    // Expose theme properties for convenient access in views
    var colorScheme: ColorScheme? { selectedTheme.colorScheme }
    var accentColor: Color { selectedTheme.accentColor }

    var background: Color { selectedTheme.background }
    var secondaryBackground: Color { selectedTheme.secondaryBackground }
    var listRowBackground: Color { selectedTheme.listRowBackground }
    var primaryText: Color { selectedTheme.primaryText }
    var secondaryText: Color { selectedTheme.secondaryText }

    private func save() {
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: Self.key)
    }

    private static let key = "ThemeStore.selectedTheme"
}
