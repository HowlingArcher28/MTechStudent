import SwiftUI

struct AtticJournalScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Leather Journal",
            description: "The first line reads, “On All Hallows’ Eve, the house remembers its own.” The last page smells faintly of smoke.",
            systemImage: "text.book.closed.fill",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Search for the Missing Page",
                    subtitle: "Soot smudges trail toward a ceiling beam.",
                    systemImage: "magnifyingglass",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: { setScene(.hiddenPage) }
                ),
                SceneChoice(
                    title: "Close the Journal",
                    subtitle: "The latch clicks and the sound lingers.",
                    systemImage: "xmark.circle.fill",
                    colors: [Color.orange, Color.pink],
                    foreground: .black,
                    action: { setScene(.attic) }
                )
            ]
        )
    }
}
