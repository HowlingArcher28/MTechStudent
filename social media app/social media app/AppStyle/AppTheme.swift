/*
 AppTheme.swift
 
 Overview:
 Centralized theme constants and a view modifier that applies the app's
 preferred colors, fonts, and tint across SwiftUI views. Provides a convenient
 `.appTheme()` extension for consistent styling.
*/

import SwiftUI

struct AppTheme {
    static let primaryRed = Color(red: 0.65, green: 0.05, blue: 0.07)

    static let accent = LinearGradient(
        colors: [primaryRed, primaryRed],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let tintColor: Color = primaryRed

    static let defaultFont: Font = .system(.body, design: .default)

    static let background: some View = Color(.systemBackground)
}

private struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(.light)
            .tint(AppTheme.tintColor)
            .environment(\.font, AppTheme.defaultFont)
            .foregroundStyle(.primary)
            .background(AppTheme.background.ignoresSafeArea())
    }
}

extension View {
    func appTheme() -> some View {
        modifier(AppThemeModifier())
    }
}

