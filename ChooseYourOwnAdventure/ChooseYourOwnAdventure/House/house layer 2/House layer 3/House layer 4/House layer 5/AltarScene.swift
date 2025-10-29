import SwiftUI

struct AltarScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Stone Altar",
            description: "A bowl, a candle, a line you choose to cross.",
            systemImage: "flame.fill",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Swear a Pact",
                    subtitle: "Power, and its teeth.",
                    systemImage: "seal.fill",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: { setScene(.endingPact) }
                )
            ]
        )
    }
}
