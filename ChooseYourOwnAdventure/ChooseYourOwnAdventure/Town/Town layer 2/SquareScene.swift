import SwiftUI

struct SquareScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Town Square",
            description: "Pumpkins grin with too many teeth. Children chase shadows that chase back.",
            systemImage: "music.note",
            gradient: [Color.cyan, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Fountain",
                    subtitle: "Coins like cold stars under the skin of the water.",
                    systemImage: "drop.circle.fill",
                    colors: [Color.cyan, Color.blue],
                    foreground: .white,
                    action: { setScene(.fountain) }
                ),
                SceneChoice(
                    title: "Visit the Vendor",
                    subtitle: "Charms that hum when you touch them.",
                    systemImage: "bag.fill",
                    colors: [Color.teal, Color.blue],
                    foreground: .white,
                    action: { setScene(.vendor) }
                ),
                SceneChoice(
                    title: "Follow the Lantern Trail",
                    subtitle: "A ribbon of light slips into the alleys.",
                    systemImage: "lantern.fill",
                    colors: [Color.orange, Color.cyan],
                    foreground: .black,
                    action: { setScene(.lanternRow) }
                )
            ]
        )
    }
}
