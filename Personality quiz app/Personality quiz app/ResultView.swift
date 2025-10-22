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
    
    var body: some View {
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
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer(minLength: 0)
                
                Text("Your Color Match")
                    .font(.system(.title, design: .rounded).weight(.semibold))
                    .foregroundStyle(.secondary)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(color.opacity(0.18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .strokeBorder(color.opacity(0.35), lineWidth: 1)
                        )
                        .shadow(color: color.opacity(0.25), radius: 18, x: 0, y: 10)
                        .overlay(resultCardHighlight)
                        .frame(maxWidth: 420, maxHeight: 260)
                    
                    VStack(spacing: 14) {
                        Circle()
                            .fill(color)
                            .frame(width: 120, height: 120)
                            .shadow(color: color.opacity(0.55), radius: 14, x: 0, y: 8)
                        
                        Text(colorName)
                            .font(.system(.title2, design: .rounded).weight(.bold))
                            .foregroundStyle(.primary)
                        
                        Text(description(for: colorName))
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding()
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
                        Capsule().fill(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
                            .shadow(color: .blue.opacity(0.35), radius: 14, x: 0, y: 8)
                    )
                }
                .buttonStyle(ScaleOnPressStyle())
                .padding(.horizontal, 36)
                
                Spacer(minLength: 0)
            }
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }
}

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
    case "Red": return "You’re energetic, passionate, and love to take the lead."
    case "Yellow": return "You’re optimistic, bright, and bring joy to those around you."
    case "Blue": return "You’re calm, thoughtful, and dependable."
    case "Purple": return "You’re imaginative, confident, and a bit mysterious."
    default: return "A unique blend that’s all you."
    }
}
