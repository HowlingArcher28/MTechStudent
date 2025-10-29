import SwiftUI

struct EndingWanderView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Wanderer",
            description: "You choose the open road. The way ahead is quiet and clear.",
            systemImage: "figure.walk.motion",
            gradient: [Color.purple, Color.mint],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Another road is already unfolding.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.purple, Color.mint],
                    foreground: .black,
                    action: onPlayAgain
                )
            ]
        )
    }
}
