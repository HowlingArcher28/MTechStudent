import SwiftUI

struct PrayerCandleScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "Prayer Candle",
            description: "The flame burns blue. The bell rings once, from inside your chest.",
            systemImage: "candle.fill",
            gradient: [Color.blue, Color.indigo],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Call to the Spirit",
                    subtitle: "A soft voice answers with your own accent, years older.",
                    systemImage: "person.wave.2.fill",
                    colors: [Color.blue, Color.indigo],
                    foreground: .white,
                    action: { setScene(.spirit) }
                ),
                SceneChoice(
                    title: "Make a Wish",
                    subtitle: "The flame bows. Something listens.",
                    systemImage: "sparkles",
                    colors: [Color.cyan, Color.indigo],
                    foreground: .white,
                    action: { setScene(.endingBlessing) }
                )
            ]
        )
    }
}
