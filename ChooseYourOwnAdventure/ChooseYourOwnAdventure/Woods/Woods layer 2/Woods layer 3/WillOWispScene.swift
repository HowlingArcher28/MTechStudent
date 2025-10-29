import SwiftUI

struct WillOWispScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Will-o’-the-Wisp",
            description: "It pauses over a path that wasn’t there a blink ago.",
            systemImage: "sparkle",
            gradient: [Color.cyan, Color.teal],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Hidden Path",
                    subtitle: "It brightens when you doubt.",
                    systemImage: "point.topleft.down.curvedto.point.bottomright.up",
                    colors: [Color.cyan, Color.teal],
                    foreground: .black,
                    action: { setScene(.hiddenPath) }
                )
            ]
        )
    }
}
