import SwiftUI

struct MidnightParadeScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Midnight Parade",
            description: "Masks, music, and mirrors. Every step moves the town’s hands closer together.",
            systemImage: "music.quarternote.3",
            gradient: [Color.orange, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Walk at the Center",
                    subtitle: "The street opens like a book.",
                    systemImage: "heart.circle.fill",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.townHeart) }
                )
            ]
        )
    }
}
