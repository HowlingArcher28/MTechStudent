import SwiftUI

struct ForestHeartScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Heart of the Forest",
            description: "Leaves whisper your name in a dozen languages. A warmth settles behind your ribs.",
            systemImage: "leaf.fill",
            gradient: [Color.mint, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Blessing",
                    subtitle: "You smell rain, ripe fruit, and home.",
                    systemImage: "sun.max.fill",
                    colors: [Color.mint, Color.green],
                    foreground: .black,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
