import SwiftUI

struct WhisperStairScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Whispering Stair",
            description: "Words rise like breath between the steps: your secrets, spoken by strangers.",
            systemImage: "figure.stairs",
            gradient: [Color.orange, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Descend",
                    subtitle: "You hear your name said right behind your ear.",
                    systemImage: "arrow.down.circle.fill",
                    colors: [Color.orange, Color.indigo],
                    foreground: .white,
                    action: { setScene(.lockedStudy) }
                )
            ]
        )
    }
}
