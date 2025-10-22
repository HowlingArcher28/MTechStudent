//
//  ContentView.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showQuiz = false
    @State private var animate = false

    var body: some View {
        NavigationStack {
            ZStack {
                //MARK: - Background gradient
                RadialGradient(
                    colors: [
                        Color.blue.opacity(0.25),
                        Color.purple.opacity(0.20),
                        Color.indigo.opacity(0.15),
                        Color.black.opacity(0.05)
                    ],
                    center: .topLeading,
                    startRadius: 80,
                    endRadius: 800
                )
                .ignoresSafeArea()

                //MARK: - Decorative blurred bubbles
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.25))
                        .frame(width: 220, height: 220)
                        .blur(radius: 40)
                        .offset(x: -140, y: -220)
                        .opacity(animate ? 1 : 0.85)
                        .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate)

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(width: 260, height: 260)
                        .blur(radius: 50)
                        .offset(x: 160, y: 240)
                        .opacity(animate ? 1 : 0.85)
                        .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true), value: animate)
                }

                //MARK: - Content container
                VStack {
                    Spacer(minLength: 0)

                    ZStack {
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28, style: .continuous)
                                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 18, x: 0, y: 10)
                            .overlay(highlightOverlay)
                            .frame(maxWidth: 460)
                            .padding(.horizontal)

                        // Center-align everything inside the card
                        VStack(alignment: .center, spacing: 22) {
                            //MARK: - Title
                            Text("What Color Are You?")
                                .font(.system(.largeTitle, design: .rounded).bold())
                                .multilineTextAlignment(.center)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.pink, .purple, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                                .padding(.top, 8)
                                .padding(.horizontal, 24)

                            //MARK: - Subtitle
                            Text("Answer a few quick questions to discover the color that best matches your personality.")
                                .font(.system(.body, design: .rounded))
                                .foregroundStyle(.primary.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 28)

                            //MARK: - Start button
                            Button {
                                showQuiz = true
                            } label: {
                                HStack(spacing: 8) {
                                    Text("Start Quiz")
                                    Image(systemName: "arrow.right.circle.fill")
                                }
                                .font(.system(.headline, design: .rounded).weight(.semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(
                                            LinearGradient(
                                                colors: [.purple, .blue],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                )
                                .shadow(color: Color.blue.opacity(0.35), radius: 14, x: 0, y: 8)
                                .padding(.horizontal, 36)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(ScaleOnPressStyle())

                            //MARK: - How it works (centered)
                            VStack(alignment: .center, spacing: 12) {
                                HStack(spacing: 8) {
                                    Image(systemName: "sparkles")
                                        .foregroundStyle(.purple)
                                    Text("How it works")
                                        .font(.system(.subheadline, design: .rounded).weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)

                                VStack(spacing: 10) {
                                    howItWorksRow(icon: "checkmark.circle.fill", color: .blue, text: "Answer 5 quick questions")
                                    howItWorksRow(icon: "slider.horizontal.3", color: .purple, text: "Mix of choices and sliders")
                                    howItWorksRow(icon: "paintpalette.fill", color: .pink, text: "Get your color match instantly")
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(.horizontal, 28)
                            .padding(.top, 2)

                            //MARK: - Possible matches (centered)
                            VStack(alignment: .center, spacing: 10) {
                                HStack(spacing: 8) {
                                    Image(systemName: "circle.grid.2x2.fill")
                                        .foregroundStyle(.blue)
                                    Text("Possible matches")
                                        .font(.system(.subheadline, design: .rounded).weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)

                                HStack(spacing: 14) {
                                    colorSwatch(.red, name: "Red")
                                    colorSwatch(.yellow, name: "Yellow")
                                    colorSwatch(.blue, name: "Blue")
                                    colorSwatch(.purple, name: "Purple")
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(.horizontal, 28)

                            //MARK: - Small footer hint
                            Text("Takes less than a minute!")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                        }
                        .frame(maxWidth: 460, maxHeight: 560, alignment: .top)
                        .padding(.vertical, 22)
                    }

                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .navigationDestination(isPresented: $showQuiz) {
                QuizView()
            }
            .onAppear {
                animate = true
            }
        }
    }

    //MARK: - Subtle top highlight for the glass card
    private var highlightOverlay: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .stroke(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.45),
                        Color.white.opacity(0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
            .blendMode(.overlay)
            .allowsHitTesting(false)
    }

    //MARK: - Helpers
    private func howItWorksRow(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(text)
                .font(.system(.callout, design: .rounded))
                .foregroundStyle(.primary.opacity(0.9))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(color.opacity(0.10))
        )
    }

    private func colorSwatch(_ color: Color, name: String) -> some View {
        VStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 34, height: 34)
                .shadow(color: color.opacity(0.35), radius: 6, x: 0, y: 3)
            Text(name)
                .font(.system(.caption2, design: .rounded).weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white.opacity(0.20), lineWidth: 1)
                )
        )
    }
}

//MARK: - Button style that scales slightly on press for better feedback
struct ScaleOnPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

#Preview {
    ContentView()
}
