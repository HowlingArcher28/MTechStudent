import SwiftUI

struct HeartOfHouseScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Heart of the House",
            description: "Beams curve like ribs around a furnace that beats. It slows when you breathe.",
            systemImage: "heart.circle.fill",
            gradient: [Color.red, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Offer Your Name",
                    subtitle: "The beat matches yours. Then yours matches it.",
                    systemImage: "person.text.rectangle.fill",
                    colors: [Color.red, Color.orange],
                    foreground: .white,
                    action: { setScene(.endingPossessed) }
                ),
                SceneChoice(
                    title: "Run for the Door",
                    subtitle: "Dawn is a razor you can barely reach.",
                    systemImage: "figure.run.circle.fill",
                    colors: [Color.orange, Color.yellow],
                    foreground: .black,
                    action: { setScene(.endingEscapeDawn) }
                ),
                SceneChoice(
                    title: "Refuse to Speak",
                    subtitle: "The house forgets you. You forget the house.",
                    systemImage: "mouth.fill",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.endingLostTime) }
                )
            ]
        )
    }
}
