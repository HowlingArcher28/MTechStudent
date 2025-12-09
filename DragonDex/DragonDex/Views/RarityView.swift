// RarityView.swift
import SwiftUI

struct RarityView: View {
    let rarity: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<max(0, rarity), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundStyle(.yellow)
            }
        }
        .accessibilityLabel("\(rarity) star rarity")
    }
}
