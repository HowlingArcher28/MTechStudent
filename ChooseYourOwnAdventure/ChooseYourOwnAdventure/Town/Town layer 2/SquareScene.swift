import SwiftUI

struct SquareScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Town Square",
            description: "Carved pumpkins glow. Children run across the square, laughing.",
            systemImage: "music.note",
            gradient: [Color.cyan, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Fountain",
                    subtitle: "Coins shine beneath the water.",
                    systemImage: "drop.circle.fill",
                    colors: [Color.cyan, Color.blue],
                    foreground: .white,
                    action: { setScene(.fountain) }
                ),
                SceneChoice(
                    title: "Visit the Vendor",
                    subtitle: "Charms hum softly when you touch them.",
                    systemImage: "bag.fill",
                    colors: [Color.teal, Color.blue],
                    foreground: .white,
                    action: { setScene(.vendor) }
                ),
                SceneChoice(
                    title: "Follow the Lantern Trail",
                    subtitle: "A line of lanterns leads into the alleys.",
                    systemImage: "lantern.fill",
                    colors: [Color.orange, Color.cyan],
                    foreground: .black,
                    action: { setScene(.lanternRow) }
                )
            ]
        )
    }
}
