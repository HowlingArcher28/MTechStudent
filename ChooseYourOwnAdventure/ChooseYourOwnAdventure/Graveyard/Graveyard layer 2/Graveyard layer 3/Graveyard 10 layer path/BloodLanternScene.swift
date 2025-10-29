import SwiftUI

struct BloodLanternScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Blood Lantern",
            description: "A lantern filled with something thicker than oil. It glows when you speak softly.",
            systemImage: "lamp.table.fill",
            gradient: [Color.red, Color.black],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Raise the Light",
                    subtitle: "Shadows retreat like a tide.",
                    systemImage: "flashlight.on.fill",
                    colors: [Color.red, Color.black],
                    foreground: .white,
                    action: { setScene(.finalVigil) }
                )
            ]
        )
    }
}
