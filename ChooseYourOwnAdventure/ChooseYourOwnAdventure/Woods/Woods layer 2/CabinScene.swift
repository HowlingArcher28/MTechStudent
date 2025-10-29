import SwiftUI

struct CabinScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Cabin",
            description: "The door opens itself. The hearth glows without flame.",
            systemImage: "door.left.hand.open",
            gradient: [Color.purple, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Check the Pantry",
                    subtitle: "Something taps to be let out.",
                    systemImage: "cabinet.fill",
                    colors: [Color.purple, Color.orange],
                    foreground: .white,
                    action: { setScene(.pantry) }
                ),
                SceneChoice(
                    title: "Sit by the Hearth",
                    subtitle: "Heat without fire, comfort without source.",
                    systemImage: "flame",
                    colors: [Color.orange, Color.purple],
                    foreground: .white,
                    action: { setScene(.hearth) }
                ),
                SceneChoice(
                    title: "Read the Letter on the Table",
                    subtitle: "Your name in a hand you almost remember.",
                    systemImage: "envelope.open.fill",
                    colors: [Color.indigo, Color.orange],
                    foreground: .white,
                    action: { setScene(.cabinLetter) }
                )
            ]
        )
    }
}
