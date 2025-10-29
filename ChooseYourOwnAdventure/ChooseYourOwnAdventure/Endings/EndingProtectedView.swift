import SwiftUI

struct EndingProtectedView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Protected",
            description: "The charm glows softly. The dark keeps its distance, counting.",
            systemImage: "shield.fill",
            gradient: [Color.teal, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Walk another road.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.teal, Color.cyan],
                    foreground: .black,
                    action: onPlayAgain
                )
            ]
        )
    }
}
