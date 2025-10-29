import SwiftUI

struct InnScene: View {
    let setScene: (ContentView.Scene) -> Void
    let onBack: () -> Void

    var body: some View {
        SceneView(
            title: "The Inn",
            description: "Mugs clink. Stories grow teeth. The hearth swallows sparks whole.",
            systemImage: "bed.double.fill",
            gradient: [Color.blue, Color.cyan],
            onBack: onBack,
            choices: [
                SceneChoice(
                    title: "Rent a Room",
                    subtitle: "Sheets cold as a river stone.",
                    systemImage: "key.horizontal.fill",
                    colors: [Color.blue, Color.cyan],
                    foreground: .white,
                    action: { setScene(.rentedRoom) }
                ),
                SceneChoice(
                    title: "Hear the Bard’s Tale",
                    subtitle: "The chorus knows your name.",
                    systemImage: "music.note.list",
                    colors: [Color.indigo, Color.cyan],
                    foreground: .white,
                    action: { setScene(.bardTale) }
                )
            ]
        )
    }
}
