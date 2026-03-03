//
//  EnhanceView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct EnhanceView: View {

    let image: UIImage
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {

        VStack(spacing: 20) {

            Text("Enhance")
                .font(.title)

            GlassCard {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)

            }

            ProgressView(value: 0.5)
                .tint(.blue)

            Text("AI Upscaling...")

            PrimaryButton(title: "Next: Perfect Fit")
                .onTapGesture {
                    navigationManager.goToPerfectFit(image: image)
                }

            Spacer()

        }
        .padding()
    }
}

