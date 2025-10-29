import SwiftUI

struct ShadowProcessionScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Shadow Procession",
            description: "Figures in veils pass, feet not touching stone. They leave no cold in their wake.",
            systemImage: "figure.2.and.child.holdinghands",
            gradient: [Color.black, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Fall In Step",
                    subtitle: "They make room without looking.",
                    systemImage: "figure.walk",
                    colors: [Color.black, Color.gray],
                    foreground: .white,
                    action: { setScene(.oathStone) }
                )
            ]
        )
    }
}
