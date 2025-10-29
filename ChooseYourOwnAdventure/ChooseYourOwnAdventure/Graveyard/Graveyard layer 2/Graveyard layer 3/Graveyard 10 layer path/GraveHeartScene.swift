import SwiftUI

struct GraveHeartScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Heart of the Grave",
            description: "Roots clutch a stone that beats. Each pulse knows your name now.",
            systemImage: "heart.fill",
            gradient: [Color.red, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Accept the Bond",
                    subtitle: "A second heartbeat settles beneath your own.",
                    systemImage: "heart.circle.fill",
                    colors: [Color.red, Color.gray],
                    foreground: .white,
                    action: { setScene(.endingBound) }
                )
            ]
        )
    }
}
