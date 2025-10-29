import SwiftUI

struct EndingPactView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: The Pact",
            description: "You keep your promise. The house takes its due.",
            systemImage: "seal.fill",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Try a different path.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
