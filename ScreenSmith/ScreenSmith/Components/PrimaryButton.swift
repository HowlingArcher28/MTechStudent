//
//  PrimaryButton.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String

    var body: some View {
        Text(title)
            .font(.headline.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(NeonColors.neonBlue.opacity(0.16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(LinearGradient(colors: [NeonColors.neonBlue.opacity(0.9), NeonColors.neonBlue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(NeonColors.neonBlue.opacity(0.06))
                            .blur(radius: 20)
                    )
            )
            .neonGlow(color: NeonColors.neonBlue, radius: 16, intensity: 0.7)
    }
}
