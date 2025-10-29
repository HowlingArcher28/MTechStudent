import SwiftUI

struct LanternMothScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Lantern Moth",
            description: "A moth with a faint glow in its wings hovers, waiting to be followed.",
            systemImage: "bolt.heart.fill",
            gradient: [Color.cyan, Color.teal],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Moth",
                    subtitle: "It pauses when you doubt.",
                    systemImage: "scope",
                    colors: [Color.cyan, Color.teal],
                    foreground: .black,
                    action: { setScene(.riverCrossing) }
                )
            ]
        )
    }
}
