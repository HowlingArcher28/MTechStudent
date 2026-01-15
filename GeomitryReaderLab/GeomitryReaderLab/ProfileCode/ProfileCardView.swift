// ProfileCardView.swift
import SwiftUI

struct ProfileCardView: View {
    let profile: Profile
    let width: CGFloat
    let cornerRadius: CGFloat = 12
    let padding: CGFloat = 12

    var body: some View {
        let height = width * 1.25

        VStack(spacing: 8) {
            Image(systemName: profile.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(height: width * 0.35)
                .foregroundStyle(.white)
                .padding(.top, 8)

            Text(profile.name)
                .font(.headline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(profile.description)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.8)

            Spacer(minLength: 0)
        }
        .padding(padding)
        .frame(width: width, height: height, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color.black)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}
