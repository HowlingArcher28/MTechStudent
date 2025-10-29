import SwiftUI

struct PantryScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Pantry",
            description: "A jar taps from the inside. The label reads “Do Not Open.” The ink is still wet.",
            systemImage: "jar.fill",
            gradient: [Color.orange, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Open the Jar",
                    subtitle: "Curiosity is a key you always carry.",
                    systemImage: "scissors",
                    colors: [Color.orange, Color.purple],
                    foreground: .white,
                    action: { setScene(.endingWander) }
                )
            ]
        )
    }
}
