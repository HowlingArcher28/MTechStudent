import SwiftUI

struct LockedStudyScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Locked Study",
            description: "A desk with a keyhole. The key is a tooth. Yours.",
            systemImage: "lock.square.fill",
            gradient: [Color.indigo, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Use the Tooth",
                    subtitle: "The lock tastes like rust and thunder.",
                    systemImage: "key.fill",
                    colors: [Color.indigo, Color.orange],
                    foreground: .white,
                    action: { setScene(.ashParlor) }
                )
            ]
        )
    }
}
