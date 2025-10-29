import SwiftUI

struct EndingReunionView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Reunion",
            description: "A familiar hand in yours. You walk together out of the page.",
            systemImage: "heart.circle.fill",
            gradient: [Color.orange, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "They will be waiting.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.orange, Color.gray],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
