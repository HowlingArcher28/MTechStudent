//
//  ContentView.swift
//  CountDown
//
//  Created by Zachary Jensen on 12/9/25.
//

import SwiftUI

import UIKit


struct ContentView: View {
    private let sequence: [String] = ["3", "2", "1", "GO!"]
    private let stepInterval: Duration = .seconds(1)
    

    @State private var isRunning = false
    @State private var currentToken: String? = nil
    @State private var countdownTask: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 28) {
            Text("Race Countdown")
                .font(.largeTitle.bold())

            ZStack {
                Text("0")
                    .opacity(0)
                    .font(.system(size: 120, weight: .black, design: .rounded))

                if let token = currentToken {
                    Text(token)
                        .font(.system(size: token == "GO!" ? 110 : 120, weight: .black, design: .rounded))
                        .kerning(2)
                        .foregroundStyle(token == "GO!" ? .green : .primary)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .transition(.scale(scale: 0.2, anchor: .center).combined(with: .opacity))
                        .id(token)
                        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: token)
                        .accessibilityLabel(token == "GO!" ? "Go" : token)
                }
            }
            .frame(height: 180)

            Button(action: handleButtonTap) {
                Text(isRunning ? "Running…" : "Start")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(isRunning ? Color.gray.opacity(0.15) : Color.blue.opacity(0.15))
                    .foregroundStyle(isRunning ? .gray : .blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .disabled(isRunning)
            .padding(.horizontal, 24)

            Text("Tap Start to begin a racing 3‑2‑1‑GO countdown.")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .padding()
        .onDisappear {
            cancelCountdown()
        }
    }

    private func handleButtonTap() {
        guard !isRunning else { return }
        startCountdown()
    }

    private func startCountdown() {
        cancelCountdown()
        isRunning = true

        countdownTask = Task {
            for (index, token) in sequence.enumerated() {
                print("running")
                await MainActor.run {
                    withAnimation {
                        currentToken = token
                    }
                    playHaptic(for: token)
                }

                if index < sequence.count - 1 {
                    try? await Task.sleep(for: stepInterval)
                } else {
                    return
                }
                if Task.isCancelled { return }
            }

            await MainActor.run {
                withAnimation(.easeOut(duration: 0.2)) {
                    currentToken = nil
                }
                isRunning = false
            }
        }
    }

    private func cancelCountdown() {
        countdownTask?.cancel()
        countdownTask = nil
        isRunning = false
    }

    private func playHaptic(for token: String) {
        if token == "GO!" {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
}

#Preview {
    ContentView()
}
