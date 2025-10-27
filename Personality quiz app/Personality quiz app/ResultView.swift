//
//  ResultView.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/21/25.
//

import SwiftUI

struct ResultView: View {
    let color: Color
    let colorName: String
    let onRetake: () -> Void

    @State private var animate = false

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer(minLength: 0)

                VStack(spacing: 6) {
                    Text("Your Color Match")
                        .font(.system(.subheadline, design: .rounded).weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text(colorName)
                        .font(.system(.largeTitle, design: .rounded).bold())
                        .foregroundStyle(
                            LinearGradient(
                                colors: gradientForColor(color),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                        .accessibilityLabel("Your color match is \(colorName)")
                }

                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.18), radius: 18, x: 0, y: 10)
                        .overlay(resultCardHighlight)
                        .frame(maxWidth: 460, maxHeight: 320)

                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(color)
                                .frame(width: 126, height: 126)
                                .shadow(color: color.opacity(0.55), radius: 16, x: 0, y: 10)
                                .scaleEffect(animate ? 1.03 : 1.0)
                                .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: animate)

                            //MARK: - Soft highlight
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.55), Color.white.opacity(0.05)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                                .frame(width: 126, height: 126)
                                .blendMode(.overlay)
                                .allowsHitTesting(false)

                            //MARK: - Shine moving bubble
                            shineOverlay
                                .frame(width: 126, height: 126)
                                .clipShape(Circle())
                                .opacity(0.6)
                                .rotationEffect(.degrees(animate ? 25 : -25))
                                .offset(x: animate ? 18 : -18, y: animate ? -18 : 18)
                                .animation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true), value: animate)
                        }

                        Text(description(for: colorName))
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.primary.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .accessibilityLabel(description(for: colorName))
                    }
                    .padding(22)
                }

                Button {
                    onRetake()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                        Text("Retake Quiz")
                    }
                    .font(.system(.headline, design: .rounded).weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        Capsule().fill(
                            LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
                        )
                        .shadow(color: .blue.opacity(0.35), radius: 14, x: 0, y: 8)
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.22), lineWidth: 1)
                    )
                    .contentShape(Rectangle())
                }
                .buttonStyle(ScaleOnPressStyle())
                .padding(.horizontal, 36)

                Spacer(minLength: 0)
            }
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { animate = true }
    }

    // MARK: - Background
    private var background: some View {
        ZStack {
            RadialGradient(
                colors: [
                    color.opacity(0.20),
                    Color.purple.opacity(0.16),
                    Color.indigo.opacity(0.12),
                    Color.black.opacity(0.05)
                ],
                center: .topLeading,
                startRadius: 80,
                endRadius: 900
            )

            //MARK: - Subtle color-driven bubbles
            Circle()
                .fill(color.opacity(0.22))
                .frame(width: 240, height: 240)
                .blur(radius: 44)
                .offset(x: -150, y: -220)
                .opacity(animate ? 1 : 0.85)
                .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate)

            Circle()
                .fill(secondaryAccent(for: color).opacity(0.22))
                .frame(width: 280, height: 280)
                .blur(radius: 50)
                .offset(x: 170, y: 240)
                .opacity(animate ? 1 : 0.85)
                .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true), value: animate)
        }
    }

    // MARK: - Shine overlay for the swatch
    private var shineOverlay: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .white.opacity(0.00), location: 0.0),
                .init(color: .white.opacity(0.35), location: 0.35),
                .init(color: .white.opacity(0.00), location: 0.75)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .blendMode(.screen)
        .allowsHitTesting(false)
    }
}

// MARK: - Overlays and helpers

private var resultCardHighlight: some View {
    RoundedRectangle(cornerRadius: 28, style: .continuous)
        .stroke(
            LinearGradient(
                colors: [
                    Color.white.opacity(0.5),
                    Color.white.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            lineWidth: 1
        )
        .blendMode(.overlay)
        .allowsHitTesting(false)
}

private func description(for colorName: String) -> String {
    switch colorName {
    case "Red": return "You’re energetic, passionate, and love to take the lead!"
    case "Yellow": return "You’re optimistic, bright, and bring joy to those around you!"
    case "Blue": return "You’re calm, thoughtful, and dependable!"
    case "Purple": return "You’re imaginative, confident, and a bit mysterious..."
    default: return "A unique blend that’s all you."
    }
}

private func gradientForColor(_ color: Color) -> [Color] {
    if color == .red { return [.pink, .red] }
    if color == .yellow { return [.orange, .yellow] }
    if color == .blue { return [.blue, .indigo] }
    if color == .purple { return [.purple, .pink] }
    return [.gray, .gray.opacity(0.8)]
}

private func secondaryAccent(for color: Color) -> Color {
    if color == .red { return .orange }
    if color == .yellow { return .orange }
    if color == .blue { return .purple }
    if color == .purple { return .blue }
    return .indigo
}
