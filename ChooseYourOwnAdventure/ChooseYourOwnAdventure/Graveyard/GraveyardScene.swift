import SwiftUI

struct GraveyardScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Graveyard",
            description: "Names worn to smooth bone. The mist holds its breath for you.",
            systemImage: "cross.fill",
            gradient: [Color.gray, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Enter the Crypt",
                    subtitle: "The door yawns wider than the dark.",
                    systemImage: "skull.fill",
                    colors: [Color.gray.opacity(0.92), Color.indigo],
                    foreground: .white,
                    action: { setScene(.crypt) }
                ),
                SceneChoice(
                    title: "Inspect the Mausoleum",
                    subtitle: "You read what the rain couldn’t wash away.",
                    systemImage: "rectangle.3.group.fill",
                    colors: [Color.gray.opacity(0.8), Color.indigo],
                    foreground: .white,
                    action: { setScene(.mausoleum) }
                )
            ]
        )
    }
}
