import SwiftUI

struct MusicBoxScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Music Box",
            description: "A ballerina turns with a broken neck. The tune runs backward.",
            systemImage: "music.quarternote.3",
            gradient: [Color.red, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Wind It",
                    subtitle: "Your fingers come away black.",
                    systemImage: "goforward",
                    colors: [Color.red, Color.orange],
                    foreground: .white,
                    action: { setScene(.portraitGallery) }
                )
            ]
        )
    }
}
