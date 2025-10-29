import SwiftUI

struct HiddenPathScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hidden Path",
            description: "Moss glows faintly. The trees have grown ears.",
            systemImage: "leaf.fill",
            gradient: [Color.teal, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Enter the Fairy Glen",
                    subtitle: "Laughter like chimes in a deep well.",
                    systemImage: "wand.and.stars",
                    colors: [Color.mint, Color.green],
                    foreground: .black,
                    action: { setScene(.fairyGlen) }
                )
            ]
        )
    }
}
