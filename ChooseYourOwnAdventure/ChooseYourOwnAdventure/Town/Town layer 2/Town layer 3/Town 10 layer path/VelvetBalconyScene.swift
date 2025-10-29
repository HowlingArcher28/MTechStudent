import SwiftUI

struct VelvetBalconyScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Velvet Balcony",
            description: "Below, lanterns gather like stars that chose the ground.",
            systemImage: "binoculars.fill",
            gradient: [Color.pink, Color.orange],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Join the Midnight Parade",
                    subtitle: "Drums count down something only you hear.",
                    systemImage: "figure.walk",
                    colors: [Color.pink, Color.orange],
                    foreground: .white,
                    action: { setScene(.midnightParade) }
                )
            ]
        )
    }
}
