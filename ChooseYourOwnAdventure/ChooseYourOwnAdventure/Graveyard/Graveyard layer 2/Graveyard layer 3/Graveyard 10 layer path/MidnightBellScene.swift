import SwiftUI

struct MidnightBellScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Midnight Bell",
            description: "A rope descends into darkness. The bell tolls once when you touch it.",
            systemImage: "bell.fill",
            gradient: [Color.indigo, Color.black],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Ring Again",
                    subtitle: "The second toll answers from below.",
                    systemImage: "bell.badge.fill",
                    colors: [Color.indigo, Color.black],
                    foreground: .white,
                    action: { setScene(.shadowProcession) }
                )
            ]
        )
    }
}
