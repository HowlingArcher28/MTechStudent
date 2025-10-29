import SwiftUI

struct MaskAlleyScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Mask Alley",
            description: "Strings of masks turn to follow you. One looks exactly like you, asleep.",
            systemImage: "theatermasks.fill",
            gradient: [Color.pink, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Cut Through the Market",
                    subtitle: "Stalls whisper prices under their breath.",
                    systemImage: "cart.fill",
                    colors: [Color.pink, Color.orange],
                    foreground: .white,
                    action: { setScene(.whisperMarket) }
                )
            ]
        )
    }
}
