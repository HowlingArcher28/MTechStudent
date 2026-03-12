import SwiftUI

// MARK: - Neon Colors
public enum NeonColors {
    public static let backgroundTop = Color(red: 0.04, green: 0.06, blue: 0.12)   // deep navy
    public static let backgroundBottom = Color(red: 0.02, green: 0.03, blue: 0.08)

    public static let neonBlue = Color(red: 0.10, green: 0.80, blue: 1.00)
    public static let neonCyan = Color(red: 0.20, green: 0.95, blue: 1.00)
    public static let neonPurple = Color(red: 0.65, green: 0.40, blue: 1.00)
    public static let neonPink = Color(red: 1.00, green: 0.35, blue: 0.75)
    public static let neonGreen = Color(red: 0.30, green: 1.00, blue: 0.70)
}

// MARK: - Neon Background
public struct NeonBackground: View {
    public init() {}
    public var body: some View {
        LinearGradient(colors: [NeonColors.backgroundTop, NeonColors.backgroundBottom],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .overlay(
                RadialGradient(colors: [NeonColors.neonBlue.opacity(0.18), .clear],
                               center: .topLeading,
                               startRadius: 0,
                               endRadius: 350)
                    .blur(radius: 60)
                    .blendMode(.screen)
            )
            .overlay(
                RadialGradient(colors: [NeonColors.neonPurple.opacity(0.14), .clear],
                               center: .bottomTrailing,
                               startRadius: 0,
                               endRadius: 420)
                    .blur(radius: 80)
                    .blendMode(.screen)
            )
    }
}

// MARK: - Glow Modifier
public struct NeonGlow: ViewModifier {
    let color: Color
    let radius: CGFloat
    let intensity: CGFloat

    public init(color: Color = NeonColors.neonBlue, radius: CGFloat = 16, intensity: CGFloat = 0.6) {
        self.color = color
        self.radius = radius
        self.intensity = intensity
    }

    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(intensity), radius: radius, x: 0, y: 0)
            .shadow(color: color.opacity(intensity * 0.7), radius: radius * 0.6, x: 0, y: 0)
            .shadow(color: color.opacity(intensity * 0.4), radius: radius * 0.3, x: 0, y: 0)
    }
}

public extension View {
    func neonGlow(color: Color = NeonColors.neonBlue, radius: CGFloat = 16, intensity: CGFloat = 0.6) -> some View {
        modifier(NeonGlow(color: color, radius: radius, intensity: intensity))
    }
}

// MARK: - Neon Capsule Button Style
public struct NeonButtonStyle: ButtonStyle {
    let color: Color
    let cornerRadius: CGFloat

    public init(color: Color = NeonColors.neonBlue, cornerRadius: CGFloat = 16) {
        self.color = color
        self.cornerRadius = cornerRadius
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(color.opacity(configuration.isPressed ? 0.22 : 0.16))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(LinearGradient(colors: [color.opacity(0.9), color.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(color.opacity(0.06))
                            .blur(radius: 20)
                    )
            )
            .neonGlow(color: color, radius: configuration.isPressed ? 10 : 16, intensity: configuration.isPressed ? 0.4 : 0.7)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

// MARK: - Neon Card Container
public struct NeonCard<Content: View>: View {
    let color: Color
    let content: Content

    public init(color: Color = NeonColors.neonBlue, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white.opacity(0.02))
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(color.opacity(0.06))
                    .blur(radius: 30)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(LinearGradient(colors: [color.opacity(0.8), color.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            )
            .overlay(
                content
                    .padding(16)
            )
            .neonGlow(color: color, radius: 18, intensity: 0.5)
    }
}

// MARK: - Neon Slider Style (visual wrapper)
public struct NeonSlider<Content: View>: View {
    let color: Color
    let value: Double
    let content: Content

    public init(color: Color = NeonColors.neonBlue, value: Double, @ViewBuilder content: () -> Content) {
        self.color = color
        self.value = value
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
                .foregroundStyle(.white.opacity(0.9))
                .font(.subheadline.weight(.semibold))
                .neonGlow(color: color.opacity(0.8), radius: 8, intensity: 0.35)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    GeometryReader { geo in
                        let width = max(0, min(geo.size.width, geo.size.width * value))
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [color.opacity(0.9), color.opacity(0.4)], startPoint: .leading, endPoint: .trailing))
                                .frame(width: width)
                                .animation(.easeOut(duration: 0.25), value: value)
                        }
                    }
                )
                .frame(height: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color.opacity(0.6), lineWidth: 1)
                )
                .neonGlow(color: color, radius: 12, intensity: 0.35)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Usage Examples (comment-only)
/*
 Wrap your top-level view with the background:
 ZStack {
     NeonBackground()
     Content()
 }

 Apply to buttons:
 Button("Save to Gallery") { /* action */ }
     .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue))

 Neon text/glow:
 Text("Enhance")
     .font(.largeTitle.bold())
     .foregroundStyle(.white)
     .neonGlow(color: NeonColors.neonCyan, radius: 20, intensity: 0.5)

 Card groupings:
 NeonCard(color: NeonColors.neonPurple) {
     VStack(alignment: .leading) {
         Text("Options").foregroundStyle(.white)
         Toggle("Smart Crop", isOn: $smartCrop)
     }
 }
*/
