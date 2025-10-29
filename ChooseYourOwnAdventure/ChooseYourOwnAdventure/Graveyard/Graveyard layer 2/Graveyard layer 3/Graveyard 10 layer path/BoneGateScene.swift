import SwiftUI

struct BoneGateScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Bone Gate",
            description: "Bars made of femurs and iron. The lock is a jaw that yawns when you whisper.",
            systemImage: "lock.open",
            gradient: [Color.gray, Color.black],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Whisper Your Name",
                    subtitle: "The teeth click, amused.",
                    systemImage: "mouth.fill",
                    colors: [Color.gray, Color.black],
                    foreground: .white,
                    action: { setScene(.ossuaryHall) }
                )
            ]
        )
    }
}
