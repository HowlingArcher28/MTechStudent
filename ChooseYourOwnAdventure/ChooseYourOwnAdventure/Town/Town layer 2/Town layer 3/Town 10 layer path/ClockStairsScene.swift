import SwiftUI

struct ClockStairsScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Clock Tower Stairs",
            description: "Narrow steps curl around a heart that beats in hours.",
            systemImage: "clock.fill",
            gradient: [Color.blue, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Enter the Bell Foundry",
                    subtitle: "The molds remember every voice.",
                    systemImage: "bell.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.bellFoundry) }
                )
            ]
        )
    }
}
