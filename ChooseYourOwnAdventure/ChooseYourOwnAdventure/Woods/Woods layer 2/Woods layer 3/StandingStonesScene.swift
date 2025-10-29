import SwiftUI

struct StandingStonesScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Standing Stones",
            description: "Runes glow under your skin. Your shadow bends the wrong way.",
            systemImage: "triangle.circle.fill",
            gradient: [Color.purple, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Touch the Rune",
                    subtitle: "It hums in your teeth.",
                    systemImage: "hand.tap.fill",
                    colors: [Color.purple, Color.cyan],
                    foreground: .white,
                    action: { setScene(.portal) }
                ),
                SceneChoice(
                    title: "Back Away",
                    subtitle: "The hum follows, softer.",
                    systemImage: "arrow.uturn.backward.circle.fill",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.woods) }
                )
            ]
        )
    }
}
