import SwiftUI

struct RingCurseScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Ring",
            description: "A second heartbeat, closer than skin.",
            systemImage: "circle.hexagonpath.fill",
            gradient: [Color.gray, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Let the Ring Choose",
                    subtitle: "It tightens, then loosens, then decides.",
                    systemImage: "circle.dashed.inset.filled",
                    colors: [Color.gray, Color.red],
                    foreground: .white,
                    action: { setScene(.endingBound) }
                ),
                SceneChoice(
                    title: "Drop the Ring",
                    subtitle: "It lands without a sound, like a mouth closing.",
                    systemImage: "arrow.down.circle.fill",
                    colors: [Color.gray, Color.red],
                    foreground: .white,
                    action: { setScene(.graveyard) }
                )
            ]
        )
    }
}
