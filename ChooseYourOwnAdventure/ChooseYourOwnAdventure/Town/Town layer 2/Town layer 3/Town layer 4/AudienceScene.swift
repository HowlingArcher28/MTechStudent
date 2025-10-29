import SwiftUI

struct AudienceScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Audience",
            description: "Cheers, claps, smiles. The sound is a tide that won’t let you go.",
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
