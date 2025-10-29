import SwiftUI

struct AudienceScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Audience",
            description: "The crowd claps and cheers. The sound swells and fills the room.",
            systemImage: "person.3.sequence.fill",
            gradient: [Color.purple, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Bow",
                    subtitle: "The bard nods, satisfied.",
                    systemImage: "hand.thumbsup.fill",
                    colors: [Color.purple, Color.cyan],
                    foreground: .white,
                    action: { setScene(.endingApplause) }
                )
            ]
        )
    }
}
