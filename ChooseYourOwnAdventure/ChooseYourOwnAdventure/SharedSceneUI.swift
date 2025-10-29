import SwiftUI

// Shared UI components extracted for reuse by all scene files.

struct FancyChoiceButton: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let colors: [Color]
    let foreground: Color
    let action: () -> Void

    @State private var isPressed = false
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: 13) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(scheme == .dark ? 0.13 : 0.20))
                        .shadow(color: colors.last?.opacity(0.25) ?? .black.opacity(0.18), radius: 6, x: 0, y: 2)
                    Image(systemName: systemImage)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(foreground)
                        .shadow(color: colors.last?.opacity(0.42) ?? .black.opacity(0.25), radius: 3, x: 0, y: 1)
                }
                .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(foreground)
                        .shadow(color: .black.opacity(0.11), radius: 1, x: 0, y: 1)
                    Text(subtitle)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(foreground.opacity(0.85))
                        .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(foreground.opacity(0.96))
                    .shadow(color: colors.last?.opacity(0.22) ?? .black.opacity(0.12), radius: 2, x: 0, y: 1)
                    .padding(.leading, 4)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .shadow(color: colors.last?.opacity(0.38) ?? .black.opacity(0.20), radius: 16, x: 0, y: 8)
                    .shadow(color: .white.opacity(0.12), radius: 2, x: 0, y: 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(LinearGradient(colors: colors.map { $0.opacity(0.7) }, startPoint: .top, endPoint: .bottom), lineWidth: 1.2)
                    .shadow(color: .white.opacity(0.12), radius: 1, x: 0, y: 0)
            )
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .scaleEffect(isPressed ? 0.975 : 1)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.white.opacity(isPressed ? 0.08 : 0.12))
                    .blendMode(.plusLighter)
                    .animation(.easeInOut(duration: 0.18), value: isPressed)
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.9), value: isPressed)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in if !isPressed { isPressed = true } }
                .onEnded { _ in isPressed = false }
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(title))
        .accessibilityHint(Text(subtitle))
    }
}

struct SceneChoice: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let systemImage: String
    let colors: [Color]
    let foreground: Color
    let action: () -> Void
}

struct SceneView: View {
    let title: String
    let description: String
    let systemImage: String
    let gradient: [Color]
    let onBack: () -> Void
    var choices: [SceneChoice] = []

    @State private var iconGlow = false
    @State private var show = false

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: onBack) {
                    Label("Back", systemImage: "arrow.left")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 12).padding(.vertical, 7)
                        .background(Color.white.opacity(0.13))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.13), radius: 2, x: 0, y: 1)
                }
                .buttonStyle(.plain)
                .scaleEffect(show ? 1 : 0.96)
                .opacity(show ? 1 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.02), value: show)
                Spacer()
            }
            .padding(.top, 8)

            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [gradient.first?.opacity(0.41) ?? .orange.opacity(0.33), .clear]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 52
                        )
                    )
                    .frame(width: 92, height: 92)
                    .blur(radius: iconGlow ? 5 : 1)
                    .scaleEffect(iconGlow ? 1.08 : 1)
                    .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: iconGlow)
                Circle()
                    .strokeBorder(gradient.first ?? .orange, lineWidth: 2)
                    .opacity(0.18)
                    .frame(width: 60, height: 60)
                Image(systemName: systemImage)
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(
                        LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
                    )
                    .shadow(color: gradient.first?.opacity(0.48) ?? .orange.opacity(0.44), radius: 6, x: 0, y: 2)
                    .rotationEffect(.degrees(iconGlow ? 1.8 : -1.8))
                    .animation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: iconGlow)
            }
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.95)
            .animation(.spring(response: 0.6, dampingFraction: 0.9).delay(0.04), value: show)
            .onAppear { iconGlow = true }

            Text(title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: sanitizedTitleColors(from: gradient),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial.opacity(0.28), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 0.8)
                )
                .multilineTextAlignment(.center)
                .padding(.top, 3)
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : 8)
                .animation(.easeOut(duration: 0.4).delay(0.08), value: show)

            Text(description)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(Color.white.opacity(0.92))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
                .padding(.bottom, 10)
                .shadow(color: .black.opacity(0.14), radius: 1, x: 0, y: 1)
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : 10)
                .animation(.easeOut(duration: 0.45).delay(0.12), value: show)

            if !choices.isEmpty {
                VStack(spacing: 12) {
                    ForEach(Array(choices.enumerated()), id: \.element.id) { index, choice in
                        FancyChoiceButton(
                            title: choice.title,
                            subtitle: choice.subtitle,
                            systemImage: choice.systemImage,
                            colors: choice.colors,
                            foreground: choice.foreground,
                            action: choice.action
                        )
                        .opacity(show ? 1 : 0)
                        .offset(y: show ? 0 : 12)
                        .animation(.spring(response: 0.6, dampingFraction: 0.9).delay(0.16 + 0.06 * Double(index)), value: show)
                    }
                }
                .frame(maxWidth: 380)
                .padding(.top, 4)
            }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear { show = true }
        .onDisappear { show = false }
    }

    private func sanitizedTitleColors(from colors: [Color]) -> [Color] {
        let safe = colors.map { c -> Color in
            switch c {
            case .black:
                return .white
            default:
                return c
            }
        }
        return safe + [.white.opacity(0.95)]
    }
}

struct FogOverlay: View {
    @State private var offsetX: CGFloat = -300
    @State private var opacity: Double = 0.18

    var body: some View {
        ZStack {
            fogLayer(width: 1200, height: 500, blur: 28, baseOpacity: opacity)
                .offset(x: offsetX, y: -120)
            fogLayer(width: 1000, height: 450, blur: 24, baseOpacity: opacity * 0.9)
                .offset(x: -offsetX * 0.7, y: 180)
        }
        .blendMode(.screen)
        .onAppear {
            withAnimation(.easeInOut(duration: 18).repeatForever(autoreverses: true)) {
                offsetX = 300
            }
            withAnimation(.easeInOut(duration: 12).repeatForever(autoreverses: true)) {
                opacity = 0.24
            }
        }
        .allowsHitTesting(false)
    }

    private func fogLayer(width: CGFloat, height: CGFloat, blur: CGFloat, baseOpacity: Double) -> some View {
        LinearGradient(colors: [Color.white.opacity(0.0), Color.white.opacity(baseOpacity), Color.white.opacity(0.0)],
                       startPoint: .leading, endPoint: .trailing)
            .frame(width: width, height: height)
            .blur(radius: blur)
    }
}

struct FirefliesOverlay: View {
    @State private var t: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                let count = 18
                for i in 0..<count {
                    let p = path(for: i, time: t, in: size)
                    var circle = Path()
                    circle.addEllipse(in: CGRect(x: p.x, y: p.y, width: 3.5, height: 3.5))
                    let alpha = 0.35 + 0.25 * sin((t * 2) + CGFloat(i))
                    context.fill(circle, with: .color(Color.yellow.opacity(Double(alpha))))
                    var glow = Path()
                    glow.addEllipse(in: CGRect(x: p.x - 4, y: p.y - 4, width: 12, height: 12))
                    context.fill(glow, with: .color(Color.orange.opacity(Double(alpha * 0.35))))
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    t = 1
                }
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }

    private func path(for index: Int, time: CGFloat, in size: CGSize) -> CGPoint {
        let speed = 0.2 + 0.15 * CGFloat((index % 5))
        let phase = CGFloat(index) * 0.37
        let x = (sin((time * 2 * speed) + phase) * (size.width * 0.45)) + (size.width * 0.5)
        let y = (cos((time * 1.6 * speed) + phase) * (size.height * 0.35)) + (size.height * 0.5)
        return CGPoint(x: x, y: y)
    }
}
