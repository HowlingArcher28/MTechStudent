import SwiftUI

struct SubmergedScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Submerged",
            description: "Light blooms below like an eye opening.",
            systemImage: "drop.triangle.fill",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Swim Toward the Light",
                    subtitle: "The doorway is wider than the well.",
                    systemImage: "figure.pool.swim",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.endingDrowned) }
                )
            ]
        )
    }
}
