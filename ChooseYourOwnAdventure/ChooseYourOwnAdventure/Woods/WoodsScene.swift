import SwiftUI

struct WoodsScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Into the Woods",
            description: "Trees lean in to listen. The fog tastes like pennies.",
            systemImage: "tree.fill",
            gradient: [Color.purple, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Clearing",
                    subtitle: "A pale light that never quite arrives.",
                    systemImage: "sparkles",
                    colors: [Color.purple.opacity(0.98), Color.indigo.opacity(0.96)],
                    foreground: .white,
                    action: { setScene(.clearing) }
                ),
                SceneChoice(
                    title: "Knock on the Cabin",
                    subtitle: "Smoke smells like sugar and bones.",
                    systemImage: "house",
                    colors: [Color(red: 0.50, green: 0.28, blue: 0.68), Color.indigo],
                    foreground: .white,
                    action: { setScene(.cabin) }
                )
            ]
        )
    }
}
