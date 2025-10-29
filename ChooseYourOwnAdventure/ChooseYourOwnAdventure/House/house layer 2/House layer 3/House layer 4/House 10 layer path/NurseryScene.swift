import SwiftUI

struct NurseryScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Abandoned Nursery",
            description: "A cradle rocks itself. The wallpaper is children’s faces; some blink.",
            systemImage: "figure.child.circle.fill",
            gradient: [Color.orange, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Hush the Cradle",
                    subtitle: "It stops. Something else starts.",
                    systemImage: "hand.raised.fill",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.musicBox) }
                )
            ]
        )
    }
}
