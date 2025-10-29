import SwiftUI

struct HollowLogScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Hollow Log",
            description: "Mushrooms ring the entrance. Inside smells like rain that forgot the sky.",
            systemImage: "circle.dashed",
            gradient: [Color.brown, Color.green],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Crawl Through",
                    subtitle: "Something tiny runs across your knuckles.",
                    systemImage: "hand.point.right.fill",
                    colors: [Color.brown, Color.green],
                    foreground: .white,
                    action: { setScene(.lanternMoth) }
                )
            ]
        )
    }
}
