import SwiftUI

struct ClearingScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Moonlit Clearing",
            description: "Fireflies drift in the dark. The wind settles and the clearing is still.",
            systemImage: "moon.stars.fill",
            gradient: [Color.indigo, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Circle of Stones",
                    subtitle: "Older than the trees, worn smooth by time.",
                    systemImage: "hexagon.fill",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.standingStones) }
                ),
                SceneChoice(
                    title: "Chase a Will-o’-the-Wisp",
                    subtitle: "It drifts toward the deeper woods.",
                    systemImage: "flame.fill",
                    colors: [Color.purple, Color.cyan],
                    foreground: .white,
                    action: { setScene(.willOWisp) }
                ),
                SceneChoice(
                    title: "Follow the Glimmering Trail",
                    subtitle: "Tiny lights thread deeper between the birches.",
                    systemImage: "sparkles",
                    colors: [Color.mint, Color.teal],
                    foreground: .black,
                    action: { setScene(.glimmerTrail) }
                )
            ]
        )
    }
}
