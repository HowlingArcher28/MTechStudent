import SwiftUI

struct OathStoneScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Oath Stone",
            description: "A slab etched with names. Your breath fogs the letters and adds a line.",
            systemImage: "text.badge.checkmark",
            gradient: [Color.gray, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Place Your Hand",
                    subtitle: "The stone warms, then cools.",
                    systemImage: "hand.raised.fill",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.veiledPriest) }
                )
            ]
        )
    }
}
