import SwiftUI

struct MausoleumScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Mausoleum",
            description: "Stone cold, breath warm. A ring glints like a wet eye.",
            systemImage: "rectangle.3.group.fill",
            gradient: [Color.gray.opacity(0.9), Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Pick Up the Ring",
                    subtitle: "A warmth climbs your arm like a vine.",
                    systemImage: "circle.hexagongrid.fill",
                    colors: [Color.gray.opacity(0.9), Color.indigo],
                    foreground: .white,
                    action: { setScene(.ringCurse) }
                ),
                SceneChoice(
                    title: "Search for a Hidden Niche",
                    subtitle: "Stone seams betray a secret.",
                    systemImage: "square.stack.3d.down.right.fill",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.hiddenNiche) }
                )
            ]
        )
    }
}
