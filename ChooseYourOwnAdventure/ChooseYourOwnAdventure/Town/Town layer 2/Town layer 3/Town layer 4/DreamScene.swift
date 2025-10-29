import SwiftUI

struct DreamScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "A Gentle Dream",
            description: "You walk at dusk. A door ahead opens as if it knew you were coming.",
            systemImage: "cloud.moon.fill",
            gradient: [Color.cyan, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Knock",
                    subtitle: "You hear familiar footsteps approach.",
                    systemImage: "hand.tap.fill",
                    colors: [Color.cyan, Color.purple],
                    foreground: .white,
                    action: { setScene(.endingRest) }
                )
            ]
        )
    }
}
