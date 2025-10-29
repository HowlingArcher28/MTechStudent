import SwiftUI

struct EndingConsumedView: View {
    let onBack: () -> Void
    let onPlayAgain: () -> Void

    var body: some View {
        SceneView(
            title: "Ending: Consumed",
            description: "The candles cough out. The dark pours in. The house finally eats.",
            systemImage: "smoke.fill",
            gradient: [Color.red, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Play Again",
                    subtitle: "There’s always more to devour.",
                    systemImage: "arrow.counterclockwise.circle.fill",
                    colors: [Color.red, Color.orange],
                    foreground: .white,
                    action: onPlayAgain
                )
            ]
        )
    }
}
