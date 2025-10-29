import SwiftUI

struct BellFoundryScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Bell Foundry",
            description: "Cooling metal hums the low note of your name.",
            systemImage: "bell.fill",
            gradient: [Color.indigo, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Cross the Rooftop Wires",
                    subtitle: "Laundry and secrets flap in the wind.",
                    systemImage: "square.grid.3x3.fill.square",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.rooftopWires) }
                )
            ]
        )
    }
}
