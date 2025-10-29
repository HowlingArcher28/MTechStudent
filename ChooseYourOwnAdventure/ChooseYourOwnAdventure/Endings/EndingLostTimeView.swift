import SwiftUI

struct EndingLostTimeView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Lost Time",
            description: "The house forgets you. Years fall off the clock like ash. You smile and do not know why.",
            systemImage: "clock.arrow.2.circlepath",
            gradient: [Color.gray, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "Find yourself again.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
