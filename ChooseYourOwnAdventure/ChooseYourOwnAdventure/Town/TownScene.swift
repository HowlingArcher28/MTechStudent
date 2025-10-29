import SwiftUI

struct TownScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Return to Town",
            description: "Lanterns twitch in their glass. Windows watch you pass.",
            systemImage: "building.2.crop.circle",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Visit the Inn",
                    subtitle: "Laughter that never quite reaches the eyes.",
                    systemImage: "bed.double.fill",
                    colors: [Color.cyan.opacity(0.97), Color.blue.opacity(0.93)],
                    foreground: .white,
                    action: { setScene(.inn) }
                ),
                SceneChoice(
                    title: "Walk to the Square",
                    subtitle: "A musician plays a tune you dreamt last night.",
                    systemImage: "music.note",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.square) }
                )
            ]
        )
    }
}
