import SwiftUI

struct HearthScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hearth",
            description: "A pot simmers with no fuel. It smells like home and rain.",
            systemImage: "leaf.arrow.triangle.circlepath",
            gradient: [Color.orange, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Recipe",
                    subtitle: "The ink crawls when you look away.",
                    systemImage: "list.bullet.rectangle.fill",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.recipe) }
                )
            ]
        )
    }
}
