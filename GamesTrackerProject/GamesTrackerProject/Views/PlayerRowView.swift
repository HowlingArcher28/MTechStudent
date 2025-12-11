//
//  PlayerRowView.swift
//  GamesTrackerProject
//

import SwiftUI
import SwiftData

struct PlayerRowView: View {
    @Bindable var player: Player
    var onChange: (Int) -> Void
    @Namespace private var rowNS

    @State private var displayedScore: Int = 0
    @State private var isMinusPressed: Bool = false
    @State private var isPlusPressed: Bool = false
    @State private var flashColor: Color? = nil

    private func impact() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
    }

    private var scoreBackground: some View {
        Capsule()
            .fill(Color.accentColor.opacity(0.10))
    }

    private var flashOverlay: some View {
        Capsule()
            .fill((flashColor ?? .clear).opacity(0.22))
            .animation(.easeOut(duration: 0.18), value: flashColor)
    }

    private func flash(_ color: Color) {
        flashColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            withAnimation(.easeOut(duration: 0.18)) {
                flashColor = nil
            }
        }
    }

    private func pressFeedback(isPlus: Bool) {
        withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
            if isPlus { isPlusPressed = true } else { isMinusPressed = true }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                if isPlus { isPlusPressed = false } else { isMinusPressed = false }
            }
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: player.icon)
                .frame(width: 28, height: 28)
                .padding(6)
                .background(Circle().fill(Color.gray.opacity(0.15)))
                .matchedGeometryEffect(id: "icon-\(player.id)", in: rowNS)

            Text(player.name)
                .font(.body)
                .lineLimit(1)
                .matchedGeometryEffect(id: "name-\(player.id)", in: rowNS)

            Spacer()

            HStack(spacing: 8) {
                Button {
                    impact()
                    pressFeedback(isPlus: false)
                    displayedScore -= 1
                    onChange(-1)
                    flash(.red)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.red)
                        .scaleEffect(isMinusPressed ? 0.9 : 1.0)
                        .accessibilityLabel("Decrease score")
                }
                .buttonStyle(.plain)

                // Score
                Text("\(displayedScore)")
                    .font(.system(.body, design: .rounded))
                    .monospacedDigit()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        ZStack {
                            scoreBackground
                            flashOverlay
                        }
                    )
                    .matchedGeometryEffect(id: "score-\(player.id)", in: rowNS)

                // Plus
                Button {
                    impact()
                    pressFeedback(isPlus: true)
                    displayedScore += 1
                    onChange(+1)
                    flash(.green)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.green)
                        .scaleEffect(isPlusPressed ? 0.9 : 1.0)
                        .accessibilityLabel("Increase score")
                }
                .buttonStyle(.plain)
            }
        }
        .contentShape(Rectangle())
        
        .onAppear { displayedScore = player.score }
        .onChange(of: player.score) { _, newValue in
    
            if newValue != displayedScore {
                withAnimation(.easeInOut(duration: 0.15)) {
                    displayedScore = newValue
                }
            }
        }
    }
}

