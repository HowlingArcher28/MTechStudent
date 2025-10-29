import SwiftUI

struct LanternRowScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Lantern Row",
            description: "Paper lanterns sway like slow heartbeats. Each one blinks when you pass.",
            systemImage: "lantern.fill",
            gradient: [Color.orange, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Slip into the Alley",
                    subtitle: "Masks smile from the dark.",
                    systemImage: "theatermasks.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.maskAlley) }
                )
            ]
        )
    }
}
