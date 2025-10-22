//
//  QuizView.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/21/25.
//
import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        ZStack {
            animatedGradientBackground
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Progress
                VStack(spacing: 8) {
                    Text(viewModel.progressText)
                        .font(.system(.subheadline, design: .rounded).weight(.medium))
                        .foregroundStyle(.secondary)

                    progressBar(progress: viewModel.progressFraction)
                        .padding(.horizontal)
                }

                // Card
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 16, x: 0, y: 10)
                        .overlay(cardHighlightOverlay)

                    VStack(alignment: .leading, spacing: 18) {
                        Text(viewModel.currentQuestion.prompt)
                            .font(.system(.title2, design: .rounded).weight(.semibold))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)

                        switch viewModel.currentQuestion.kind {
                        case .multipleChoice:
                            VStack(spacing: 10) {
                                ForEach(viewModel.currentQuestion.choices) { choice in
                                    ChoiceRow(
                                        text: choice.text,
                                        isSelected: viewModel.isChoiceSelected(choice),
                                        tap: { viewModel.handleChoiceTap(choice) }
                                    )
                                }
                            }

                        case let .slider(min, max, step):
                            VStack(alignment: .leading, spacing: 14) {
                                HStack {
                                    Text("\(Int(min))")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    Text("\(Int(max))")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundStyle(.secondary)
                                }

                                Slider(
                                    value: Binding(
                                        get: { viewModel.sliderValue },
                                        set: { viewModel.sliderChanged(to: $0) }
                                    ),
                                    in: min...max,
                                    step: step
                                )
                                .tint(.blue)
                                .shadow(color: .blue.opacity(0.15), radius: 6, x: 0, y: 2)

                                HStack(spacing: 8) {
                                    Text("Your answer")
                                        .font(.system(.footnote, design: .rounded))
                                        .foregroundStyle(.secondary)
                                    Text("\(Int(viewModel.sliderValue))")
                                        .font(.system(.headline, design: .rounded).weight(.semibold))
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule().fill(Color.blue.opacity(0.12))
                                        )
                                }
                            }
                        }

                        Button(action: viewModel.goToNext) {
                            HStack(spacing: 8) {
                                Text(viewModel.buttonTitle)
                                Image(systemName: viewModel.buttonIconName)
                            }
                            .font(.system(.headline, design: .rounded).weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(viewModel.buttonBackground)
                                    .shadow(color: .blue.opacity(viewModel.isCurrentQuestionAnswered ? 0.35 : 0.0), radius: 12, x: 0, y: 6)
                            )
                        }
                        .buttonStyle(ScaleOnPressStyle())
                        .disabled(!viewModel.isCurrentQuestionAnswered)
                        .padding(.top, 6)
                    }
                    .padding(22)
                    .frame(maxWidth: 420)
                }
                .frame(height: 460)
                .padding(.horizontal)

                Spacer(minLength: 0)
            }
            .padding(.top, 12)
        }
        .navigationTitle("Quiz")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background.opacity(0.001))
        .onAppear { viewModel.onAppear() }
        .onChange(of: viewModel.currentIndex) { _, _ in
            viewModel.onQuestionIndexChanged()
        }
        .navigationDestination(isPresented: $viewModel.showResult) {
            let (color, name) = viewModel.finalColor()
            ResultView(color: color, colorName: name) {
                viewModel.resetQuiz()
            }
        }
    }

    // MARK: - Background (static)
    private var animatedGradientBackground: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.blue.opacity(0.20),
                    Color.purple.opacity(0.18),
                    Color.indigo.opacity(0.12),
                    Color.black.opacity(0.04)
                ],
                center: .topLeading,
                startRadius: 80,
                endRadius: 900
            )
            .opacity(0.95)

            // Static blurred bubbles
            Circle()
                .fill(Color.purple.opacity(0.25))
                .frame(width: 220, height: 220)
                .blur(radius: 40)
                .offset(x: -150, y: -220)

            Circle()
                .fill(Color.blue.opacity(0.25))
                .frame(width: 260, height: 260)
                .blur(radius: 50)
                .offset(x: 170, y: 240)
        }
    }

    // MARK: - Progress bar (static width update)
    private func progressBar(progress: CGFloat) -> some View {
        GeometryReader { proxy in
            let totalWidth = min(proxy.size.width, 520)
            let filled = max(10, totalWidth * progress)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.secondary.opacity(0.12))
                    .frame(width: totalWidth, height: 10)

                Capsule()
                    .fill(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
                    .frame(width: filled, height: 10)
            }
            .frame(width: totalWidth, height: 10, alignment: .leading)
            .accessibilityLabel("Progress")
            .accessibilityValue("\(Int(progress * CGFloat(max(1,  viewModel.questions.count)))) of \(viewModel.questions.count)")
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 10)
    }

    // Subtle top highlight for the glass card
    private var cardHighlightOverlay: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .stroke(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.55),
                        Color.white.opacity(0.10)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
            .blendMode(.overlay)
            .allowsHitTesting(false)
    }
}
