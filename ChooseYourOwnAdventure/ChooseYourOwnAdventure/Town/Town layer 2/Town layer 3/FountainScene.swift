import SwiftUI

struct FountainScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Fountain",
            description: "The water sings under its breath. It remembers everyone.",
            systemImage: "drop.circle.fill",
            gradient: [Color.cyan, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Make a Wish",
                    subtitle: "It answers in ripples along your spine.",
                    systemImage: "sparkles",
                    colors: [Color.cyan, Color.blue],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
