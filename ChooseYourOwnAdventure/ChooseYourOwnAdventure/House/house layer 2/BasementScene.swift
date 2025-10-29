import SwiftUI

struct BasementScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Basement",
            description: "Damp stone. The drip has a rhythm, like a lullaby you almost remember.",
            systemImage: "light.recessed.3.fill",
            gradient: [Color(red: 0.6, green: 0.3, blue: 0.1), Color.brown],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Open the Hidden Door",
                    subtitle: "Wax-smell and a hush.",
                    systemImage: "door.left.hand.open",
                    colors: [Color(red: 0.7, green: 0.35, blue: 0.15), Color.brown],
                    foreground: .white,
                    action: { setScene(.basementHiddenDoor) }
                ),
                SceneChoice(
                    title: "Peer into the Old Well",
                    subtitle: "Your reflection whispers a word you never learned.",
                    systemImage: "drop.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.basementWell) }
                )
            ]
        )
    }
}
