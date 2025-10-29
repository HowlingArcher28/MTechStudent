import SwiftUI

struct PortraitGalleryScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Portrait Gallery",
            description: "Eyes follow you. One frame is empty, still warm.",
            systemImage: "photo.on.rectangle.angled",
            gradient: [Color.orange, Color.gray],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Step into the Empty Frame",
                    subtitle: "A hand takes yours from behind the canvas.",
                    systemImage: "rectangle.and.hand.point.up.left.fill",
                    colors: [Color.orange, Color.gray],
                    foreground: .white,
                    action: { setScene(.redDoor) }
                )
            ]
        )
    }
}
