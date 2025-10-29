import SwiftUI

struct WhisperMarketScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Whisper Market",
            description: "Vendors trade rumors in paper envelopes. Every deal ends with a name.",
            systemImage: "cart.fill",
            gradient: [Color.orange, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb the Clock Stairs",
                    subtitle: "Each step ticks twice.",
                    systemImage: "clock.fill",
                    colors: [Color.orange, Color.blue],
                    foreground: .white,
                    action: { setScene(.clockStairs) }
                )
            ]
        )
    }
}
