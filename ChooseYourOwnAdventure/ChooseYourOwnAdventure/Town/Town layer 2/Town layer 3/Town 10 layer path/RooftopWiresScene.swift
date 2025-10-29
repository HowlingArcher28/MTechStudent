import SwiftUI

struct RooftopWiresScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Rooftop Wires",
            description: "You balance above the town. Every window is an eye you almost know.",
            systemImage: "building.2.crop.circle",
            gradient: [Color.cyan, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Slip Through the Stage Door",
                    subtitle: "Dust motes bow as you enter.",
                    systemImage: "door.left.hand.open",
                    colors: [Color.cyan, Color.purple],
                    foreground: .white,
                    action: { setScene(.backstageDoor) }
                )
            ]
        )
    }
}
