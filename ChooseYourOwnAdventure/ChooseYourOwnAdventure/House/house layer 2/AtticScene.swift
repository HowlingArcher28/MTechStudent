import SwiftUI

struct AtticScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Attic",
            description: "Cobwebs shiver to a wind that never arrives. A music box clicks without turning.",
            systemImage: "square.stack.3d.up.fill",
            gradient: [Color.orange, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Peer from the Window",
                    subtitle: "The town looks older, and less alive.",
                    systemImage: "window.vertical.open",
                    colors: [Color.orange, Color.pink],
                    foreground: .black,
                    action: { setScene(.atticWindow) }
                ),
                SceneChoice(
                    title: "Read the Leather Journal",
                    subtitle: "Dates end abruptly on tonight.",
                    systemImage: "book.closed.fill",
                    colors: [Color(red: 0.95, green: 0.6, blue: 0.25), Color.pink],
                    foreground: .white,
                    action: { setScene(.atticJournal) }
                ),
                SceneChoice(
                    title: "Feel Behind the Rafters",
                    subtitle: "A latch where there shouldn’t be one.",
                    systemImage: "hand.tap.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .white,
                    action: { setScene(.hiddenCorridor) }
                )
            ]
        )
    }
}
