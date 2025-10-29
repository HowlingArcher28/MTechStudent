import SwiftUI

struct VendorScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Vendor",
            description: "“Something to keep you safe,” they say. “Or something to keep you.”",
            systemImage: "bag.fill",
            gradient: [Color.teal, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Buy a Charm",
                    subtitle: "It is warm, and so are your pockets now.",
                    systemImage: "seal.fill",
                    colors: [Color.teal, Color.blue],
                    foreground: .white,
                    action: { setScene(.charmUse) }
                )
            ]
        )
    }
}
