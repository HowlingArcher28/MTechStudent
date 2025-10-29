import SwiftUI

struct CatacombsScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Catacombs",
            description: "Candles gutter. Bones are stacked like books. The air tastes of iron.",
            systemImage: "circle.grid.cross.fill",
            gradient: [Color.gray, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Chant",
                    subtitle: "It leads to a stone bowl and a choice.",
                    systemImage: "waveform",
                    colors: [Color.gray, Color.brown],
                    foreground: .white,
                    action: { setScene(.altar) }
                ),
                SceneChoice(
                    title: "Search the Shelves",
                    subtitle: "A scroll maps a library that shouldn’t exist.",
                    systemImage: "scroll.fill",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.catacombLibrary) }
                )
            ]
        )
    }
}
