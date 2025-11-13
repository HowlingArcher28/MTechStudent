import SwiftUI

struct AppTheme {
    // Primary brand color: a darker red suitable for UI chrome and accents
    static let primaryRed = Color(red: 0.65, green: 0.05, blue: 0.07)

    // Keep the existing API names but point them to the new palette
    static let accent = LinearGradient(
        colors: [primaryRed, primaryRed],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Use the brand red for interactive tints
    static let tintColor: Color = primaryRed

    // System default font for a professional look
    static let defaultFont: Font = .system(.body, design: .default)

    // Light mode white background
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
