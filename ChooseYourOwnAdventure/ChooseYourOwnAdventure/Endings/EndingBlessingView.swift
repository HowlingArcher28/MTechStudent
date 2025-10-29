import SwiftUI

struct EndingBlessingView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Blessed",
            description: "Warmth spreads through your chest. The night feels calm.",
            systemImage: "sun.max.fill",
            gradient: [Color.mint, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "The lights will be waiting.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.mint, Color.green],
                    foreground: .black,
                    action: onPlayAgain
                )
            ]
        )
    }
}
