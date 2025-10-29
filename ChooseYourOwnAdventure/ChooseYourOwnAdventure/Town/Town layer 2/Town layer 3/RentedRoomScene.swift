import SwiftUI

struct RentedRoomScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Rented Room",
            description: "A mirror under a sheet. A window that opens to last year.",
            systemImage: "bed.double.circle.fill",
            gradient: [Color.cyan, Color.blue],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Uncover the Mirror",
                    subtitle: "Reflection first, you second.",
                    systemImage: "rectangle.portrait",
                    colors: [Color.cyan, Color.blue],
                    foreground: .white,
                    action: { setScene(.dream) }
                )
            ]
        )
    }
}
