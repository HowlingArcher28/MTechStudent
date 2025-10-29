import SwiftUI

struct CryptScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Crypt",
            description: "Candles flicker. Your heartbeat sounds loud in the quiet.",
            systemImage: "skull.fill",
            gradient: [Color.gray, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "A Secret Passage",
                    subtitle: "Behind a cracked sarcophagus.",
                    systemImage: "rectangle.portrait.and.arrow.right.fill",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.secretPassage) }
                ),
                SceneChoice(
                    title: "Light a Candle",
                    subtitle: "For those who remember.",
                    systemImage: "candle.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.prayerCandle) }
                ),
                SceneChoice(
                    title: "Follow the Blue Flame",
                    subtitle: "It hovers just beyond reach, moving toward a barred arch.",
                    systemImage: "flame.fill",
                    colors: [Color.cyan, Color.indigo],
                    foreground: .white,
                    action: { setScene(.boneGate) }
                )
            ]
        )
    }
}
