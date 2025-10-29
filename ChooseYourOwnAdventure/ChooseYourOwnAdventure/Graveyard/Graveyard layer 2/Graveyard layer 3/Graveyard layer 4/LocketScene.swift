import SwiftUI

struct LocketScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Locket",
            description: "Inside are two photos: one of you, and one of the person you hoped to become.",
            systemImage: "heart.circle.fill",
            gradient: [Color.orange, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Wear the Locket",
                    subtitle: "It feels heavier than you remember.",
                    systemImage: "necklace",
                    colors: [Color.orange, Color.gray],
                    foreground: .white,
                    action: { setScene(.endingReunion) }
                )
            ]
        )
    }
}
