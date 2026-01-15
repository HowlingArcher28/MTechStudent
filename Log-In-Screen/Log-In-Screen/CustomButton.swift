//
//  CustomButton.swift
//  Log-In-Screen
//
//  Created by Zachary Jensen on 1/5/26.
//
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let cornerRadius: CGFloat = 12
        let isPressed = configuration.isPressed

        return configuration.label
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: isPressed
                            ? [Color.mtechColorDark, Color.mtechColor]
                            : [Color.mtechColorLight, Color.mtechColor],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(.white.opacity(0.18), lineWidth: 1)
                            .blendMode(.overlay)
                    )
            )
            .shadow(color: Color.mtechColorDark.opacity(isPressed ? 0.15 : 0.25),
                    radius: isPressed ? 6 : 10,
                    x: 0, y: isPressed ? 3 : 6)
            .scaleEffect(isPressed ? 0.985 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.86), value: isPressed)
    }
}

extension Color {
    static let mtechColor = Color(red: 109 / 255.0,
                                  green: 0 / 255.0,
                                  blue: 32 / 255.0)

    static let mtechColorDark = Color(red: 85 / 255.0,
                                      green: 0 / 255.0,
                                      blue: 25 / 255.0)

    static let mtechColorLight = Color(red: 130 / 255.0,
                                       green: 0 / 255.0,
                                       blue: 38 / 255.0)
}
