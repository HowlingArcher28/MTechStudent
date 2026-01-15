import SwiftUI

enum Theme {
    static let backgroundGradient: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.90, green: 0.93, blue: 0.90),
            Color(red: 0.85, green: 0.88, blue: 0.83)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension Theme {
    static let accent = Color(red: 0.62, green: 0.58, blue: 0.42)
    static let icon = Color(red: 0.55, green: 0.60, blue: 0.45)
    static let rowBackground = Color.white.opacity(0.45)
    static let rowShadow = Color.black.opacity(0.06)
}

enum Spacing {
    static let rowV: CGFloat = 8
    static let cardRadius: CGFloat = 14
}
