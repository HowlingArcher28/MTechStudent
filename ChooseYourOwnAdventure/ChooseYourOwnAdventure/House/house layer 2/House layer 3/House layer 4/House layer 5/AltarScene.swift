import SwiftUI

struct AltarScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Stone Altar",
            description: "A stone bowl and a single candle sit on the altar. You can choose to make an oath.",
            systemImage: "flame.fill",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Swear a Pact",
                    subtitle: "Power, with a cost.",
                    systemImage: "seal.fill",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: { setScene(.endingPact) }
                )
            ]
        )
    }
}
