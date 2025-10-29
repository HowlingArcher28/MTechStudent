import SwiftUI

struct HiddenPageScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Missing Page",
            description: "The note reads, “Call the house by its true name.” The ink looks fresh and dark.",
            systemImage: "doc.text.fill",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Read Aloud",
                    subtitle: "The rafters creak overhead.",
                    systemImage: "text.badge.star",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.endingMemory) }
                ),
                SceneChoice(
                    title: "Slip the Page into Your Pocket",
                    subtitle: "It warms in your pocket.",
                    systemImage: "folder.fill.badge.plus",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.hiddenCorridor) }
                )
            ]
        )
    }
}
