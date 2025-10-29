import SwiftUI

struct OssuaryHallScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Ossuary Hall",
            description: "Skulls stacked in tidy rows. One turns to face you and winks.",
            systemImage: "square.grid.3x3.fill",
            gradient: [Color.gray, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Count the Skulls",
                    subtitle: "You always lose track at thirteen.",
                    systemImage: "number",
                    colors: [Color.gray, Color.indigo],
                    foreground: .white,
                    action: { setScene(.midnightBell) }
                )
            ]
        )
    }
}
