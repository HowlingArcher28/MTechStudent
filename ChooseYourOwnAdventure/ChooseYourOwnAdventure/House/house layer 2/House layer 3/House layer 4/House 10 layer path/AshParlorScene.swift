import SwiftUI

struct AshParlorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Ash Parlor",
            description: "Soot footprints pace the room. They stop where you stand.",
            systemImage: "smoke.fill",
            gradient: [Color.gray, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Trace the Prints Backward",
                    subtitle: "You walk yourself into existence.",
                    systemImage: "arrow.uturn.backward.circle.fill",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.finalRitual) }
                )
            ]
        )
    }
}
