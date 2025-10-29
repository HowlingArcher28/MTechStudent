import SwiftUI

struct HiddenNicheScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Hidden Niche",
            description: "A wooden box tied with ribbon that frays into smoke.",
            systemImage: "shippingbox.fill",
            gradient: [Color.gray, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Untie the Ribbon",
                    subtitle: "The knot remembers your fingers.",
                    systemImage: "scissors",
                    colors: [Color.gray, Color.orange],
                    foreground: .white,
                    action: { setScene(.locket) }
                )
            ]
        )
    }
}
