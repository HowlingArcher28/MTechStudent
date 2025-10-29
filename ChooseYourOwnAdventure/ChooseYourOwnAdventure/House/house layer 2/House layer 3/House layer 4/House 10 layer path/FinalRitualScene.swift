import SwiftUI

struct FinalRitualScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Final Ritual",
            description: "Chalk circle. Candles of tallow. The walls breathe. The house waits to be named.",
            systemImage: "circle.grid.cross.fill",
            gradient: [Color.orange, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Speak the True Name",
                    subtitle: "It tastes like smoke and honey.",
                    systemImage: "textformat.size.larger",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.heartOfHouse) }
                ),
                SceneChoice(
                    title: "Smother the Candles",
                    subtitle: "Dark rushes in like water.",
                    systemImage: "wind",
                    colors: [Color.gray, Color.red],
                    foreground: .white,
                    action: { setScene(.endingConsumed) }
                )
            ]
        )
    }
}
