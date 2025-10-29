import SwiftUI

struct CabinLetterScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Letter",
            description: "“We’re so glad you found your way back.” The ink beads like sweat.",
            systemImage: "doc.text.fill",
            gradient: [Color.orange, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Pocket the Letter",
                    subtitle: "It warms like a heartbeat.",
                    systemImage: "folder.fill.badge.plus",
                    colors: [Color.orange, Color.indigo],
                    foreground: .white,
                    action: { setScene(.endingMemory) }
                )
            ]
        )
    }
}
