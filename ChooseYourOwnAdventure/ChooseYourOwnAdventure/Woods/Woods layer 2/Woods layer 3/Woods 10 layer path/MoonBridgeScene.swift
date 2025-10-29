import SwiftUI

struct MoonBridgeScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Moon Bridge",
            description: "A pale arc spans the canopy, woven from spider silk and light.",
            systemImage: "moon.haze.fill",
            gradient: [Color.indigo, Color.mint],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Cross the Arc",
                    subtitle: "It sways with your heartbeat.",
                    systemImage: "figure.walk.circle.fill",
                    colors: [Color.indigo, Color.mint],
                    foreground: .black,
                    action: { setScene(.glenThrone) }
                )
            ]
        )
    }
}
