import SwiftUI

struct HouseScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Inside the House",
            description: "The door yawns wider than it should. Dust hangs like ash. A clock ticks, but there is no clock.",
            systemImage: "house.lodge.fill",
            gradient: [Color.orange, Color(red: 0.95, green: 0.45, blue: 0.2)],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Climb the Stairs",
                    subtitle: "The railing is warm. Someone just used it.",
                    systemImage: "stairs",
                    colors: [Color.orange, Color(red: 1.0, green: 0.61, blue: 0.17)],
                    foreground: .black,
                    action: { setScene(.attic) }
                ),
                SceneChoice(
                    title: "Head to the Basement",
                    subtitle: "Air seeps up like a slow exhale.",
                    systemImage: "flashlight.on.fill",
                    colors: [Color(red: 0.85, green: 0.45, blue: 0.15), Color(red: 0.45, green: 0.20, blue: 0.05)],
                    foreground: .white,
                    action: { setScene(.basement) }
                )
            ]
        )
    }
}
