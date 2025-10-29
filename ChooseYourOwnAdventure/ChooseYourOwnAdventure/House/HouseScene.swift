import SwiftUI

struct HouseScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Inside the House",
            description: "The door opens with a dry creak. Dust drifts in the light. Somewhere deeper inside, a slow ticking echoes.",
            systemImage: "house.lodge.fill",
            gradient: [Color.orange, Color(red: 0.95, green: 0.45, blue: 0.2)],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb the Stairs",
                    subtitle: "The railing is warm, as if someone just used it.",
                    systemImage: "stairs",
                    colors: [Color.orange, Color(red: 1.0, green: 0.61, blue: 0.17)],
                    foreground: .black,
                    action: { setScene(.attic) }
                ),
                SceneChoice(
                    title: "Head to the Basement",
                    subtitle: "Cool air rises from below.",
                    systemImage: "flashlight.on.fill",
                    colors: [Color(red: 0.85, green: 0.45, blue: 0.15), Color(red: 0.45, green: 0.20, blue: 0.05)],
                    foreground: .white,
                    action: { setScene(.basement) }
                )
            ]
        )
    }
}
