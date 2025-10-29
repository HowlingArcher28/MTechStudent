import SwiftUI

struct SecretPassageScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Secret Passage",
            description: "It slopes toward a hatch. The wood is warm from someone else’s hands.",
            systemImage: "rectangle.compress.vertical",
            gradient: [Color.gray, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Force the Hatch",
                    subtitle: "Fresh air like a blade.",
                    systemImage: "arrow.up.square.fill",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.house) }
                )
            ]
        )
    }
}
