import SwiftUI

struct MossStairsScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Moss Stairs",
            description: "Steps spiral upward, soft and springing underfoot.",
            systemImage: "arrow.up.right.circle.fill",
            gradient: [Color.mint, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb",
                    subtitle: "The air sweetens with every turn.",
                    systemImage: "figure.stairs",
                    colors: [Color.mint, Color.green],
                    foreground: .black,
                    action: { setScene(.moonBridge) }
                )
            ]
        )
    }
}
