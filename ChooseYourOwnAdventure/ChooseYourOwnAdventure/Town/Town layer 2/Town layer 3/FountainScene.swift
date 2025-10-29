import SwiftUI

struct FountainScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Fountain",
            description: "Water trickles steadily into the basin. Coins line the bottom.",
            systemImage: "drop.circle.fill",
            gradient: [Color.cyan, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Make a Wish",
                    subtitle: "Ripples spread across the surface.",
                    systemImage: "sparkles",
                    colors: [Color.cyan, Color.blue],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
