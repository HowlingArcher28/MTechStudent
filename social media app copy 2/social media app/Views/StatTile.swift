//
//  StatTile.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct StatTile: View {
    let title: String
    let value: String
    var emoji: String = ""

    var body: some View {
        VStack(spacing: 6) {
            if !emoji.isEmpty {
                Text(emoji).font(.title3)
            }
            Text(value).font(.headline)
            Text(title).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(FunTheme.accentGradient.opacity(0.6), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
    }
}
