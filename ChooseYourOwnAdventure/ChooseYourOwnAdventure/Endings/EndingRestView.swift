import SwiftUI

struct EndingRestView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Rest",
            description: "You sleep, and wake to gentle light. The night kept watch at your door.",
            systemImage: "bed.double.fill",
            gradient: [Color.cyan, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Another story begins.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.cyan, Color.purple],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
