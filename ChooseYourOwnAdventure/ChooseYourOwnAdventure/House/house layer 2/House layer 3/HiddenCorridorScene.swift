import SwiftUI

struct HiddenCorridorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hidden Corridor",
            description: "Narrow as a throat. Wallpaper peels in strips that reveal teeth-like lath.",
            systemImage: "rectangle.compress.vertical",
            gradient: [Color.orange, Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Sideways Through",
                    subtitle: "You leave skin on the nails.",
                    systemImage: "figure.walk",
                    colors: [Color.orange, Color.brown],
                    foreground: .white,
                    action: { setScene(.nursery) }
                )
            ]
        )
    }
}
