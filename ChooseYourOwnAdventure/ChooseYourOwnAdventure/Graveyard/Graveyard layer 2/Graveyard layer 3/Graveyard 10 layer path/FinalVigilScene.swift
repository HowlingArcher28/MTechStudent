import SwiftUI

struct FinalVigilScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Final Vigil",
            description: "You sit among the stones until the stars blink. Something sits beside you, patient.",
            systemImage: "hourglass",
            gradient: [Color.gray, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Keep the Watch",
                    subtitle: "Dawn will find you changed.",
                    systemImage: "clock",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.graveHeart) }
                )
            ]
        )
    }
}
