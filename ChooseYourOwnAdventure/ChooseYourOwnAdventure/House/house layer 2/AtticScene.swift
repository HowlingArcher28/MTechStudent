import SwiftUI

struct AtticScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Attic",
            description: "Dry boards, low rafters, and the clean smell of cedar. A covered trunk sits by the dormer window. Somewhere, a music box clicks once.",
            systemImage: "square.stack.3d.up.fill",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Look Out the Window",
                    subtitle: "Town lights blink through a thin fog.",
                    systemImage: "window.vertical.open",
                    colors: [Color.orange, Color.pink],
                    foreground: .black,
                    action: { setScene(.atticWindow) }
                ),
                SceneChoice(
                    title: "Read the Leather Journal",
                    subtitle: "Entries stop on tonight’s date.",
                    systemImage: "book.closed.fill",
                    colors: [Color(red: 0.95, green: 0.6, blue: 0.25), Color.pink],
                    foreground: .white,
                    action: { setScene(.atticJournal) }
                ),
                SceneChoice(
                    title: "Feel Behind the Rafters",
                    subtitle: "Your fingers catch on a hidden latch.",
                    systemImage: "hand.tap.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.hiddenCorridor) }
                )
            ]
        )
    }
}
