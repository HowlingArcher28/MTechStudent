import SwiftUI

struct AtticJournalScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Leather Journal",
            description: "“On All Hallows Eve, the house remembers its own.” The last page smells like smoke.",
            systemImage: "text.book.closed.fill",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Search for the Missing Page",
                    subtitle: "Faint soot prints lead to a beam.",
                    systemImage: "magnifyingglass",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: { setScene(.hiddenPage) }
                ),
                SceneChoice(
                    title: "Close the Journal",
                    subtitle: "The click echoes too long.",
                    systemImage: "xmark.circle.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .black,
                    action: { setScene(.attic) }
                )
            ]
        )
    }
}
