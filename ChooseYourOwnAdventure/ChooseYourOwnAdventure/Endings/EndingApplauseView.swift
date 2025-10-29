import SwiftUI

struct EndingApplauseView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Applause",
            description: "You bow. They cheer. The song lingers like a promise you’re happy to keep.",
            systemImage: "music.mic",
            gradient: [Color.blue, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Encore.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.blue, Color.purple],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
