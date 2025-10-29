import SwiftUI

struct DreamScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "A Gentle Dream",
            description: "You walk at dusk. The door you knock on opens from the inside of your chest.",
            systemImage: "cloud.moon.fill",
            gradient: [Color.cyan, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Knock",
                    subtitle: "Footsteps, familiar and slow.",
                    systemImage: "hand.tap.fill",
                    colors: [Color.cyan, Color.purple],
                    foreground: .white,
                    action: { setScene(.endingRest) }
                )
            ]
        )
    }
}
