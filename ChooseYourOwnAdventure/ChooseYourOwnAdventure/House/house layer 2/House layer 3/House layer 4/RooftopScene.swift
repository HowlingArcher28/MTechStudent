import SwiftUI

struct RooftopScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Rooftop",
            description: "The weather vane points toward the graveyard. You swear you hear it whisper.",
            systemImage: "moon.stars.fill",
            gradient: [Color.orange, Color.yellow],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Follow the Vane’s Direction",
                    subtitle: "Climb down the gutter and drop into shadow.",
                    systemImage: "location.north.fill",
                    colors: [Color.orange, Color.yellow],
                    foreground: .black,
                    action: { setScene(.graveyard) }
                )
            ]
        )
    }
}
