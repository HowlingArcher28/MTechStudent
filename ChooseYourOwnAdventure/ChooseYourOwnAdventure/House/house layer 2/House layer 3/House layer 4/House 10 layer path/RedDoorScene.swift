import SwiftUI

struct RedDoorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Red Door",
            description: "Paint never dries here. The doorknob is a pulse.",
            systemImage: "door.left.hand.open",
            gradient: [Color.red, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Grip the Knob",
                    subtitle: "It grips you back.",
                    systemImage: "hand.raised.fingers.spread.fill",
                    colors: [Color.red, Color.orange],
                    foreground: .white,
                    action: { setScene(.whisperStair) }
                )
            ]
        )
    }
}
