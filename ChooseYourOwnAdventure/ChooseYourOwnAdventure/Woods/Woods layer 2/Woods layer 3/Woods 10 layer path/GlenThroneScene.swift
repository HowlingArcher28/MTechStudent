import SwiftUI

struct GlenThroneScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Glen Throne",
            description: "A chair of roots and flowers, vacant, expectant.",
            systemImage: "crown.fill",
            gradient: [Color.green, Color.yellow],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Take a Seat",
                    subtitle: "The glen holds its breath.",
                    systemImage: "seatbelt.alert.fill",
                    colors: [Color.green, Color.yellow],
                    foreground: .black,
                    action: { setScene(.forestHeart) }
                )
            ]
        )
    }
}
