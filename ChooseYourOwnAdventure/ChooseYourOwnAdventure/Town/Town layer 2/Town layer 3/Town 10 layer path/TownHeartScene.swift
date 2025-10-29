import SwiftUI

struct TownHeartScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Heart of Town",
            description: "The square beats once. Windows close their eyes. The night smiles with all its teeth.",
            systemImage: "heart.circle.fill",
            gradient: [Color.red, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Crown of Lights",
                    subtitle: "It fits like remembering.",
                    systemImage: "crown.fill",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.endingMemory) }
                ),
                SceneChoice(
                    title: "Step Away Quietly",
                    subtitle: "Let the town forget your name—for now.",
                    systemImage: "figure.walk",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.endingLostTime) }
                )
            ]
        )
    }
}
