import SwiftUI

struct ThornArchScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void
    var body: some View {
        SceneView(
            title: "Thorn Arch",
            description: "Bramble vines knit an archway. Dew beads like little eyes.",
            systemImage: "shield.lefthalf.filled",
            gradient: [Color.green, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Duck Through",
                    subtitle: "Threads catch on your sleeves, reluctant.",
                    systemImage: "figure.walk",
                    colors: [Color.green, Color.indigo],
                    foreground: .white,
                    action: { setScene(.hollowLog) }
                )
            ]
        )
    }
}
