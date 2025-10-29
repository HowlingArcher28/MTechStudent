import SwiftUI

struct BasementWellScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Old Well",
            description: "Still water reflects your face. The surface ripples and distorts your smile.",
            systemImage: "aqi.medium",
            gradient: [Color.blue, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb Down",
                    subtitle: "The stones are slick with moss.",
                    systemImage: "arrow.down.circle.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.submerged) }
                ),
                SceneChoice(
                    title: "Walk Away",
                    subtitle: "A faint whisper follows you up the stairs.",
                    systemImage: "arrowshape.turn.up.backward.circle.fill",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.house) }
                )
            ]
        )
    }
}
