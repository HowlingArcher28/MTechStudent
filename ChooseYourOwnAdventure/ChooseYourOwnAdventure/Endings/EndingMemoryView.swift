import SwiftUI

struct EndingMemoryView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Remembered",
            description: "You find what you came for, and the house settles into quiet. Outside, the wind moves the trees, and the night feels familiar again.",
            systemImage: "bookmark.circle.fill",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "New paths wait with the lights on.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
