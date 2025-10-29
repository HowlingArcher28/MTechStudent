import SwiftUI

struct VeiledPriestScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Veiled Priest",
            description: "A low voice from behind the cloth: 'Debt or devotion?'",
            systemImage: "person.fill.viewfinder",
            gradient: [Color.orange, Color.red],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Whisper 'Devotion'",
                    subtitle: "The veil nods once.",
                    systemImage: "hands.sparkles.fill",
                    colors: [Color.orange, Color.red],
                    foreground: .white,
                    action: { setScene(.bloodLantern) }
                )
            ]
        )
    }
}
