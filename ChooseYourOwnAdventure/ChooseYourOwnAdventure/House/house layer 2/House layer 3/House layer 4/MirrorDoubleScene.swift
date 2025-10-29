import SwiftUI

struct MirrorDoubleScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Double",
            description: "The reflection’s mouth moves. Yours does not. “Trade places? Just for the night.”",
            systemImage: "rectangle.portrait",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Trade",
                    subtitle: "The glass is warm and deep.",
                    systemImage: "arrow.left.arrow.right.circle.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.endingPossessed) }
                ),
                SceneChoice(
                    title: "Refuse and Step Back",
                    subtitle: "The smile peels away.",
                    systemImage: "xmark.circle.fill",
                    colors: [Color.orange, Color.yellow],
                    foreground: .black,
                    action: { setScene(.attic) }
                )
            ]
        )
    }
}
