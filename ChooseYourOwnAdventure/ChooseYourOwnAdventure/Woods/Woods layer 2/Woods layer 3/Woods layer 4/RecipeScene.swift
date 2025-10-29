import SwiftUI

struct RecipeScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Old Recipe",
            description: "“For warmth, for courage, for finding the way.” The last line is smudged by a tear.",
            systemImage: "book.closed.fill",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Sip the Brew",
                    subtitle: "It tastes like a memory you needed.",
                    systemImage: "mug.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
