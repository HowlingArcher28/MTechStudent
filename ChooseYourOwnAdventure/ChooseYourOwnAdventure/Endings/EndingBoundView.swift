import SwiftUI

struct EndingBoundView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Bound",
            description: "The ring’s heartbeat is your own. You never feel alone again.",
            systemImage: "circle.hexagonpath.fill",
            gradient: [Color.gray, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "If it lets you.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.gray, Color.red],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
