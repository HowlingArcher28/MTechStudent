import SwiftUI

struct SpiritScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Kind Spirit",
            description: "A gentle voice says, “Go in peace.” The spirit’s smile is calm and steady.",
            systemImage: "person.crop.circle.badge.checkmark",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Blessing",
                    subtitle: "Your shoulders feel lighter.",
                    systemImage: "sun.max.fill",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
