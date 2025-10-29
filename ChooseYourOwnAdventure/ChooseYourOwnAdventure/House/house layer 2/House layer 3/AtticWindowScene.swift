import SwiftUI

struct AtticWindowScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Attic Window",
            description: "Your reflection breathes on the glass. The fog on the pane spells your name.",
            systemImage: "moon.haze.fill",
            gradient: [Color.orange, Color.yellow],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Wave at the Reflection",
                    subtitle: "It waves first.",
                    systemImage: "hand.wave.fill",
                    colors: [Color.orange, Color.yellow],
                    foreground: .black,
                    action: { setScene(.mirrorDouble) }
                ),
                SceneChoice(
                    title: "Climb to the Rooftop",
                    subtitle: "The shingles are warm, like skin.",
                    systemImage: "square.and.arrow.up",
                    colors: [Color.orange, Color.pink],
                    foreground: .black,
                    action: { setScene(.rooftop) }
                )
            ]
        )
    }
}
