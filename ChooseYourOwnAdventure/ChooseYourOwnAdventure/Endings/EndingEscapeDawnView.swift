import SwiftUI

struct EndingEscapeDawnView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Escape at Dawn",
            description: "You reach the knife-edge of morning. The house hisses and lets you go—for now.",
            systemImage: "sunrise.fill",
            gradient: [Color.yellow, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Nightfall comes quickly here.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.yellow, Color.orange],
                    foreground: .black,
                    action: onPlayAgain
                )
            ]
        )
    }
}
