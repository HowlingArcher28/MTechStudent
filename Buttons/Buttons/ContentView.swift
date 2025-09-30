//
//  ContentView.swift
//  Buttons
//
//  Created by Zachary Jensen on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    private func next() {
        print("Next tapped")
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                Button("One", action: next)
                    .buttonStyle(GradientCapsuleButtonStyle())
                
                Button("Two", action: next)
                    .buttonStyle(OutlineCapsuleButtonStyle(borderColor: .blue, textColor: .blue))
                
                Button("Three", action: next)
                    .buttonStyle(RedWhiteBlueButtonStyle())
                
                Button("Four", action: next)
                    .buttonStyle(SomethingNew())
                
                Button("Five", action: next)
                    .buttonStyle(HoloGlassButtonStyle())
                
                Button("Six", action: next)
                    .buttonStyle(EmbossedPressButtonStyle())
                
                Button("Seven", action: next)
                    .buttonStyle(AuroraRippleButtonStyle())
                
                Button("Eight", action: next)
                    .buttonStyle(ProfessionalPrimaryButtonStyle(tint: .blue))
                
                Button(action: next) {
                    Image(systemName: "star.fill")
                        .accessibilityLabel("Favorite")
                }
                .buttonStyle(SoftNeumorphicButtonStyle(textColor: .orange))
                
                Button("Ten", action: next)
                    .buttonStyle(GlowPulseButtonStyle(tint: .purple))
            }
            .padding(.vertical, 16)
            .padding(.horizontal)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)      
        }
    }
}

// MARK: - First Button (Basic)
struct GradientCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .padding(.vertical, 13)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Second Button (Opacity change/Hollow)
struct OutlineCapsuleButtonStyle: ButtonStyle {
    var borderColor: Color = .blue
    var textColor: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 13)
            .background(
                Capsule()
                    .fill(Color.clear)
            )
            .overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Third Button (Amarica/var)
struct RedWhiteBlueButtonStyle: ButtonStyle {
    var textColor: Color = .black
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 13)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.red, .white, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Fourth Button (Neon)
struct SomethingNew: ButtonStyle {
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .background(
                ZStack {
                    Capsule(style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [.purple, .indigo, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Capsule(style: .continuous)
                        .fill(.white.opacity(0.12))
                        .blur(radius: 6)
                        .offset(y: -6)
                        .mask(
                            Capsule(style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.white, .clear],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )
                }
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [.pink, .purple, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
                    .shadow(color: .purple.opacity(0.4), radius: 6)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Fifth Button (Holographic glass + animated rainbow dash)
struct HoloGlassButtonStyle: ButtonStyle {
    var textColor: Color = .black
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 8)
            .background(
                Capsule(style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(
                        color: .black.opacity(pressed ? 0.15 : 0.30),
                        radius: pressed ? 6 : 12,
                        x: 0,
                        y: pressed ? 3 : 8
                    )
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .cyan, .blue, .indigo, .purple, .red]),
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            dash: [10, 8],
                            dashPhase: pressed ? 18 : 0
                        )
                    )
                    .rotationEffect(.degrees(pressed ? 90 : 0))
                    .shadow(color: .pink.opacity(0.35), radius: 8)
            )
            .overlay(
                Capsule(style: .continuous)
                    .fill(.white.opacity(0.08))
                    .blur(radius: 6)
                    .offset(y: -8)
                    .mask(
                        Capsule(style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.white, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
            )
            .scaleEffect(pressed ? 0.96 : 1.0)
            .rotation3DEffect(.degrees(pressed ? 12 : 0), axis: (x: 1, y: 0, z: 0))
            .animation(.spring(response: 0.28, dampingFraction: 0.75), value: pressed)
    }
}

// MARK: - Sixth Button (Border Animation)
struct EmbossedPressButtonStyle: ButtonStyle {
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.gray.opacity(0.35),
                                Color.black.opacity(0.70)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                    .blendMode(.overlay)
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.cyan.opacity(pressed ? 0.7 : 0.0), lineWidth: pressed ? 8 : 0)
                    .blur(radius: 10)
            )
            .shadow(color: .black.opacity(pressed ? 0.25 : 0.45), radius: pressed ? 6 : 12, x: pressed ? 2 : 8, y: pressed ? 2 : 8)
            .shadow(color: .white.opacity(pressed ? 0.06 : 0.12), radius: pressed ? 2 : 6, x: pressed ? -2 : -6, y: pressed ? -2 : -6)
            .scaleEffect(pressed ? 0.98 : 1.0)
            .offset(y: pressed ? 1 : 0)
            .animation(.easeOut(duration: 0.15), value: pressed)
    }
}

// MARK: - Seventh Button (Aurora ripple/hue shift)
struct AuroraRippleButtonStyle: ButtonStyle {
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [.mint, .teal, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.white.opacity(0.35), .clear],
                                center: .center,
                                startRadius: 2,
                                endRadius: 120
                            )
                        )
                        .scaleEffect(pressed ? 2.0 : 0.2)
                        .opacity(pressed ? 0.5 : 0.0)
                        .blendMode(.screen)
                }
                .allowsHitTesting(false)
                .clipShape(Capsule(style: .continuous))
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [.cyan, .mint],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: pressed ? 3 : 2
                    )
                    .shadow(color: .mint.opacity(0.35), radius: 8)
            )
            .hueRotation(.degrees(pressed ? 35 : 0))
            .scaleEffect(pressed ? 0.97 : 1.0)
            .rotation3DEffect(.degrees(pressed ? 8 : 0), axis: (x: 0, y: 1, z: 0))
            .shadow(color: .black.opacity(pressed ? 0.25 : 0.18), radius: pressed ? 10 : 6, x: 0, y: pressed ? 8 : 4)
            .animation(.spring(response: 0.28, dampingFraction: 0.75), value: pressed)
    }
}

// MARK: - Eighth Button (Professional)
struct ProfessionalPrimaryButtonStyle: ButtonStyle {
    var tint: Color = .accentColor
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline.weight(.semibold))
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
            .background(
                Capsule(style: .continuous)
                    .fill(tint)
                    .overlay(
                        LinearGradient(
                            colors: [Color.white.opacity(0.18), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(Capsule(style: .continuous))
                    )
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(tint.opacity(0.55), lineWidth: 0.75)
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.white.opacity(pressed ? 0.35 : 0.0), lineWidth: pressed ? 6 : 0)
                    .blur(radius: 10)
            )
            .shadow(color: tint.opacity(0.25), radius: pressed ? 6 : 10, x: 0, y: pressed ? 3 : 8)
            .scaleEffect(pressed ? 0.985 : 1.0)
            .brightness(pressed ? -0.05 : 0)
            .animation(.easeOut(duration: 0.12), value: pressed)
    }
}

// MARK: - Ninth Button (Soft)
struct SoftNeumorphicButtonStyle: ButtonStyle {
    var textColor: Color = .primary
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white,
                                Color(.sRGB, red: 0.94, green: 0.95, blue: 0.98, opacity: 1.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .white.opacity(pressed ? 0.4 : 0.85), radius: pressed ? 2 : 8, x: pressed ? -1 : -6, y: pressed ? -1 : -6)
                    .shadow(color: .black.opacity(pressed ? 0.10 : 0.20), radius: pressed ? 2 : 8, x: pressed ? 1 : 6, y: pressed ? 1 : 6)
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.black.opacity(pressed ? 0.10 : 0.05), lineWidth: pressed ? 2 : 1)
                    .blendMode(.multiply)
            )
            .overlay(
                Capsule(style: .continuous)
                    .fill(.white.opacity(0.10))
                    .blur(radius: 6)
                    .offset(y: -8)
                    .mask(
                        Capsule(style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.white, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
            )
            .scaleEffect(pressed ? 0.985 : 1.0)
            .animation(.easeOut(duration: 0.12), value: pressed)
    }
}

// MARK: - Tenth Button (Glowy)
struct GlowPulseButtonStyle: ButtonStyle {
    var tint: Color = .purple
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        
        return configuration.label
            .font(.headline.weight(.semibold))
            .frame(maxWidth: .infinity)
            .foregroundStyle(textColor)
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.92), Color.black.opacity(0.75)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [tint.opacity(0.9), tint.opacity(0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
                    .shadow(color: tint.opacity(0.5), radius: pressed ? 16 : 8)
                    .blur(radius: pressed ? 0 : 0) // glow comes from shadow
            )
            .overlay(
                Capsule(style: .continuous)
                    .fill(tint.opacity(0.14))
                    .blur(radius: 12)
                    .opacity(pressed ? 1 : 0.6)
            )
            .overlay(
                Capsule(style: .continuous)
                    .fill(.white.opacity(0.10))
                    .blur(radius: 6)
                    .offset(y: -8)
                    .mask(
                        Capsule(style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.white, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
            )
            .shadow(color: tint.opacity(0.35), radius: pressed ? 22 : 10)
            .scaleEffect(pressed ? 0.985 : 1.0)
            .brightness(pressed ? 0.02 : 0)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: pressed)
    }
}

#Preview {
    ContentView()
}
