import SwiftUI

struct BasementHiddenDoorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hidden Door",
            description: "A hand-carved tunnel. Scrape marks like fingernails.",
            systemImage: "tunnel.fill",
            gradient: [Color.brown, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Proceed Carefully",
                    subtitle: "Your breath returns a second late.",
                    systemImage: "figure.walk.motion",
                    colors: [Color.brown, Color.gray],
                    foreground: .white,
                    action: { setScene(.catacombs) }
                ),
                SceneChoice(
                    title: "Seal the Door",
                    subtitle: "Some tunnels should not lead anywhere.",
                    systemImage: "lock.fill",
                    colors: [Color.gray, Color.brown],
                    foreground: .white,
                    action: { setScene(.house) }
                )
            ]
        )
    }
}
