//
//  GlassCard.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct GlassCard<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            )
    }
}
