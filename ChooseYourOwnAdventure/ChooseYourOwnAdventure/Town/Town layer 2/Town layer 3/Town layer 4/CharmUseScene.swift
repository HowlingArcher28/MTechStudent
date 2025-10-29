import SwiftUI

struct CharmUseScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Charm",
            description: "A glow around you. Shadows keep their distance, counting.",
            systemImage: "seal.fill",
            gradient: [Color.teal, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Walk into the Night",
                    subtitle: "You feel watched, and safe, and watched.",
                    systemImage: "figure.walk",
                    colors: [Color.teal, Color.cyan],
                    foreground: .black,
                    action: { setScene(.endingProtected) }
                )
            ]
        )
    }
}
