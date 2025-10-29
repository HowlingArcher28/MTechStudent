import SwiftUI

struct BasementWellScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Old Well",
            description: "Still water. Your reflection smiles with someone else’s teeth.",
            systemImage: "aqi.medium",
            gradient: [Color.blue, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb Down",
                    subtitle: "Stones slick as tongues.",
                    systemImage: "arrow.down.circle.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.submerged) }
                ),
                SceneChoice(
                    title: "Walk Away",
                    subtitle: "The whisper follows, patient.",
                    systemImage: "arrowshape.turn.up.backward.circle.fill",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.house) }
                )
            ]
        )
    }
}
