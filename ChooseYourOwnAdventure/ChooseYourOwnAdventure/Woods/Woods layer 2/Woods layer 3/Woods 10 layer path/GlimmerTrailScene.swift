import SwiftUI

struct GlimmerTrailScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Glimmer Trail",
            description: "Pinpricks of light hang like beads on invisible thread, pulling you onward.",
            systemImage: "sparkles",
            gradient: [Color.teal, Color.mint],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Slip Between the Birches",
                    subtitle: "The bark is cold as paper on your cheek.",
                    systemImage: "leaf.fill",
                    colors: [Color.teal, Color.mint],
                    foreground: .black,
                    action: { setScene(.thornArch) }
                )
            ]
        )
    }
}
