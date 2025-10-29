import SwiftUI

struct LocketScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Locket",
            description: "Two faces: one is yours. The other is who you were supposed to become.",
            systemImage: "heart.circle.fill",
            gradient: [Color.orange, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Wear the Locket",
                    subtitle: "A weight you missed until now.",
                    systemImage: "necklace",
                    colors: [Color.orange, Color.gray],
                    foreground: .white,
                    action: { setScene(.endingReunion) }
                )
            ]
        )
    }
}
