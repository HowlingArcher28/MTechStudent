import SwiftUI

struct RiverCrossingScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "River Crossing",
            description: "Black water slides between stones. Your reflection blinks too slowly.",
            systemImage: "water.waves",
            gradient: [Color.blue, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Step on the Slick Stones",
                    subtitle: "The river counts your steps.",
                    systemImage: "shoeprints.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.elderOak) }
                )
            ]
        )
    }
}
