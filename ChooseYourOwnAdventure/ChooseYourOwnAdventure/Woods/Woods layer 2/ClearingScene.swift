import SwiftUI

struct ClearingScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Moonlit Clearing",
            description: "Fireflies drift like embers. The wind goes quiet to hear you better.",
            systemImage: "moon.stars.fill",
            gradient: [Color.indigo, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Circle of Stones",
                    subtitle: "Older than the trees. Hungrier, too.",
                    systemImage: "hexagon.fill",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.standingStones) }
                ),
                SceneChoice(
                    title: "Chase a Will-o’-the-Wisp",
                    subtitle: "It leads where you would not go alone.",
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
