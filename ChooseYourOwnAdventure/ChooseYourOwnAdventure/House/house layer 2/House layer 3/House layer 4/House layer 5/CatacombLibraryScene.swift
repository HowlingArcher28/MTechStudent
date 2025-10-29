import SwiftUI

struct CatacombLibraryScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hidden Library",
            description: "Books bound in bark and string. A ladder vanishes into shadow.",
            systemImage: "books.vertical.fill",
            gradient: [Color.orange, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb the Ladder",
                    subtitle: "It ends behind a chapel wall.",
                    systemImage: "ladder.fill",
                    colors: [Color.orange, Color.gray],
                    foreground: .white,
                    action: { setScene(.graveyard) }
                )
            ]
        )
    }
}
