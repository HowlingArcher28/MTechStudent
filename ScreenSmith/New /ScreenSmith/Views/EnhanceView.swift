//
//  EnhanceView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct EnhanceView: View {

    var body: some View {

        VStack(spacing: 20) {

            Text("Enhance")
                .font(.title)

            GlassCard {

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 400)
                    .overlay(
                        Text("Image Preview")
                    )

            }

            ProgressView(value: 0.5)
                .tint(.blue)

            Text("AI Upscaling...")

            Spacer()

        }
        .padding()
    }
}
