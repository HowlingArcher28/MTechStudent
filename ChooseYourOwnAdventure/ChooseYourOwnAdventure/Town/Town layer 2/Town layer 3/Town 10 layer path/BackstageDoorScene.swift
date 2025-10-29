import SwiftUI

struct BackstageDoorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Backstage Door",
            description: "Costumes breathe on their hangers. The script is written in your handwriting.",
            systemImage: "curtains.open",
            gradient: [Color.purple, Color.pink],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Step onto the Velvet Balcony",
                    subtitle: "The town holds its breath.",
                    systemImage: "eye.fill",
                    colors: [Color.purple, Color.pink],
                    foreground: .white,
                    action: { setScene(.velvetBalcony) }
                )
            ]
        )
    }
}
