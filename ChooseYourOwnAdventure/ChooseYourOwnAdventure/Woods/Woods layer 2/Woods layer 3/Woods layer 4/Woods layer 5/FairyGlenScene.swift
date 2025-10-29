import SwiftUI

struct FairyGlenScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Fairy Glen",
            description: "Tiny lanterns hang from mushrooms. Your name is a flavor on your tongue.",
            systemImage: "crown.fill",
            gradient: [Color.mint, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Bow to the Court",
                    subtitle: "They bless and bind in the same breath.",
                    systemImage: "hands.sparkles.fill",
                    colors: [Color.mint, Color.green],
                    foreground: .black,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
