import SwiftUI

struct StartScreen: View {
    var pick: (ContentView.Scene) -> Void
    @State private var glow = false
    @State private var showContent = false

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)
            // Title
            VStack(spacing: 2) {
                Text("Halloween Night")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.orange, Color.yellow, Color.pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color.orange.opacity(0.9), radius: 22, x: 0, y: 8)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial.opacity(0.25), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .scaleEffect(showContent ? 1 : 0.96)
                    .animation(.spring(response: 0.6, dampingFraction: 0.9), value: showContent)
                Text("A Choose Your Own Adventure")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
            }
            .padding(.top, 8)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 12)
            .animation(.easeOut(duration: 0.6).delay(0.05), value: showContent)

            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color.orange.opacity(0.4), Color.clear]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                    .frame(width: 127, height: 127)
                    .blur(radius: glow ? 7 : 2)
                    .scaleEffect(glow ? 1.06 : 1)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: glow)
                Circle()
                    .strokeBorder(Color.orange.opacity(0.5), lineWidth: 3)
                    .frame(width: 99, height: 99)
                    .blur(radius: 0.7)
                    .shadow(color: .orange.opacity(0.55), radius: 7, x: 0, y: 4)
                    .opacity(showContent ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.1), value: showContent)
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 54, weight: .black))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.yellow, Color.orange, Color.white.opacity(0.9)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .orange.opacity(0.8), radius: 18, x: 0, y: 9)
                    .rotationEffect(.degrees(glow ? 2 : -2))
                    .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: glow)
            }
            .padding(.top, 6)
            .onAppear {
                glow = true
                withAnimation(.spring(response: 0.7, dampingFraction: 0.85, blendDuration: 0.2)) {
                    showContent = true
                }
            }
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 14)

            // Intro text
            Text("You stand before an old house you recognize for reasons you can’t explain. The wind smells like wet leaves. A key is already in the lock.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.white.opacity(0.95))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 340)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                .padding(.vertical, 6)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 16)
                .animation(.easeOut(duration: 0.55).delay(0.1), value: showContent)

            // Choices
            VStack(spacing: 14) {
                FancyChoiceButton(
                    title: "Enter the House",
                    subtitle: "The key turns with a soft click.",
                    systemImage: "door.left.hand.open",
                    colors: [Color.orange, Color(red: 1.0, green: 0.61, blue: 0.17)],
                    foreground: .black
                ) { pick(ContentView.Scene.house) }

                FancyChoiceButton(
                    title: "Walk Into the Woods",
                    subtitle: "A narrow path winds between the trees.",
                    systemImage: "tree.fill",
                    colors: [Color.purple.opacity(0.98), Color.indigo.opacity(0.96)],
                    foreground: .white
                ) { pick(ContentView.Scene.woods) }

                FancyChoiceButton(
                    title: "Check the Graveyard",
                    subtitle: "Worn names lean in the dark.",
                    systemImage: "cross.vial",
                    colors: [Color.gray.opacity(0.92), Color.indigo],
                    foreground: .white
                ) { pick(ContentView.Scene.graveyard) }

                FancyChoiceButton(
                    title: "Return to Town",
                    subtitle: "Warm windows glow down the street.",
                    systemImage: "building.2.fill",
                    colors: [Color.cyan.opacity(0.97), Color.blue.opacity(0.93)],
                    foreground: .white
                ) { pick(ContentView.Scene.town) }
            }
            .frame(maxWidth: 380)
            .padding(.top, 8)
            .padding(.horizontal, 2)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 18)
            .animation(.easeOut(duration: 0.6).delay(0.15), value: showContent)

            Text("Choose a place to begin.")
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(Color.white.opacity(0.75))
                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                .padding(.top, 6)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.2), value: showContent)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
