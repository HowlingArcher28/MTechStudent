import SwiftUI

struct EndingView: View {
    let title: String
    let description: String
    let systemImage: String
    let gradient: [Color]

    // Customize the Play Again button appearance
    let playAgainColors: [Color]
    let playAgainForeground: Color

    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: title,
            description: description,
            systemImage: systemImage,
            gradient: gradient,
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "New paths wait with the lights on.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: playAgainColors,
                    foreground: playAgainForeground,
                    action: onPlayAgain
                )
            ]
        )
    }
}
