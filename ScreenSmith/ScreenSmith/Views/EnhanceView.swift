//
//  EnhanceView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct EnhanceView: View {

    let image: UIImage
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var pipeline: ImagePipeline

    @State private var enhancedImage: UIImage?
    @State private var isProcessing = false

    var body: some View {

        VStack(spacing: 20) {

            Text("Enhance")
                .font(.title)

            GlassCard {

                Image(uiImage: enhancedImage ?? image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)

            }

            if isProcessing || pipeline.isProcessing {
                ProgressView(value: pipeline.progress)
                    .tint(.blue)
                Text("Enhancing...")
            }

            PrimaryButton(title: "Next: Perfect Fit")
                .onTapGesture {
                    navigationManager.goToPerfectFit(image: enhancedImage ?? image)
                }

            Spacer()

        }
        .padding()
        .task {
            await runEnhancement()
        }
    }

    private func runEnhancement() async {
        isProcessing = true
        pipeline.isProcessing = true
        pipeline.progress = 0
        let enhancer = ImageEnhancer()
        // Simulate staged progress
        for step in 1...3 {
            try? await Task.sleep(nanoseconds: 250_000_000)
            pipeline.progress = Double(step) / 4.0
        }
        let output = enhancer.enhance(image)
        await MainActor.run {
            self.enhancedImage = output
        }
        pipeline.progress = 1.0
        pipeline.isProcessing = false
        isProcessing = false
    }
}
