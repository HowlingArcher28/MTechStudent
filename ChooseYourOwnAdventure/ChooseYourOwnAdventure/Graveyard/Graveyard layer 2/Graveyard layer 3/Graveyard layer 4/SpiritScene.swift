import SwiftUI

struct SpiritScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Kind Spirit",
            description: "“Go in peace,” it says. “Or go in pieces.” It smiles kindly either way.",
            systemImage: "person.crop.circle.badge.checkmark",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Blessing",
                    subtitle: "Your bones feel lighter.",
                    systemImage: "sun.max.fill",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
