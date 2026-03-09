import SwiftUI

struct FunTheme {
    
    static let cardGradient = LinearGradient(
        colors: [Color.white, Color.white],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        colors: [AppTheme.primaryRed, AppTheme.primaryRed],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let funColors: [Color] = [
        AppTheme.primaryRed, .gray, .blue, .teal, .indigo
    ]
}
