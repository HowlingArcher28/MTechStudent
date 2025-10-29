import SwiftUI

struct ElderOakScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Elder Oak",
            description: "A trunk like a tower. Bark folds like an old smile.",
            systemImage: "tree.fill",
            gradient: [Color.green, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Lay Your Hand on the Bark",
                    subtitle: "It’s warmer than your palm.",
                    systemImage: "hand.raised.fill",
                    colors: [Color.green, Color.brown],
                    foreground: .white,
                    action: { setScene(.mossStairs) }
                )
            ]
        )
    }
}
