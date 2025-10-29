import SwiftUI

struct BardTaleScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Bard",
            description: "He sings a familiar tune that matches your steps. The last verse mentions your birthday.",
            systemImage: "music.mic",
            gradient: [Color.blue, Color.purple],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Join the Chorus",
                    subtitle: "Voices rise around you.",
                    systemImage: "music.quarternote.3",
                    colors: [Color.blue, Color.purple],
                    foreground: .white,
                    action: { setScene(.audience) }
                )
            ]
        )
    }
}
