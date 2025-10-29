import SwiftUI

struct InnScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Inn",
            description: "Mugs clink, conversations grow lively, and the hearth pops with sparks.",
            systemImage: "bed.double.fill",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Rent a Room",
                    subtitle: "The sheets are cool and clean.",
                    systemImage: "key.horizontal.fill",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.rentedRoom) }
                ),
                SceneChoice(
                    title: "Hear the Bard’s Tale",
                    subtitle: "People hum along to the melody.",
                    systemImage: "music.note.list",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.bardTale) }
                )
            ]
        )
    }
}
