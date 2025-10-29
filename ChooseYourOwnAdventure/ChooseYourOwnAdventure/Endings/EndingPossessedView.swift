import SwiftUI

struct EndingPossessedView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Possessed",
            description: "You blink from the other side of the glass. Your reflection walks away in your body.",
            systemImage: "rectangle.portrait",
            gradient: [Color.pink, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Find a way back through.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.pink, Color.orange],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
