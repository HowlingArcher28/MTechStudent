import SwiftUI

struct PortalScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Portal",
            description: "The world wrinkles. A path unthreads from the air.",
            systemImage: "circle.grid.3x3.fill",
            gradient: [Color.purple, Color.mint],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Step Through",
                    subtitle: "Your heartbeat falls out of step.",
                    systemImage: "figure.walk.circle.fill",
                    colors: [Color.purple, Color.mint],
                    foreground: .black,
                    action: { setScene(.endingWander) }
                )
            ]
        )
    }
}
