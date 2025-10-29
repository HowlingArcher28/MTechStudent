import SwiftUI

struct EndingDrownedView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Below",
            description: "A doorway opens in the dark water. You swim into a place no map shows.",
            systemImage: "drop.triangle.fill",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Try again.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
