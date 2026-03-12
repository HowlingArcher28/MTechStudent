import Foundation
import SwiftUI
import Combine

@MainActor
final class ImagePipeline: ObservableObject {
    @Published var isProcessing: Bool = false
    @Published var progress: Double = 0
    @Published var lastError: Error?
    @Published var outputImage: UIImage?

    private let enhancer = ImageEnhancer()

    func process(_ image: UIImage) async {
        isProcessing = true
        progress = 0
        defer { isProcessing = false }

        for step in 1...5 {
            try? await Task.sleep(nanoseconds: 250_000_000)
            progress = Double(step) / 5.0
        }
    }

    func enhance(_ image: UIImage, sharpness: Double, vibrance: Double, autoEnhance: Bool) async -> UIImage {
        isProcessing = true
        progress = 0
        defer { isProcessing = false }

        // Simulate staged progress updates while performing real enhancement
        progress = 0.1
        let upscale: CGFloat = autoEnhance ? 3.0 : 1.0
        let unsharpIntensity: Float = Float(0.8 + sharpness * 2.0)  // 0.8 - 2.8
        let unsharpRadius: Float = Float(0.8 + sharpness * 2.2)     // 0.8 - 3.0
        let vib: Float = Float(min(1.0, max(0.0, vibrance * 1.2)))  // 0.0 - 1.0 scaled

        // Small staged delays to animate progress bar
        try? await Task.sleep(nanoseconds: 120_000_000)
        progress = 0.35

        let result = enhancer.enhance(
            image,
            upscaleFactor: upscale,
            medianRadius: 0.8,
            noiseLevel: 0.02,
            noiseSharpness: 0.35,
            unsharpRadius: unsharpRadius,
            unsharpIntensity: unsharpIntensity,
            finalDownscale: autoEnhance ? 0.92 : 1.0,
            exposureEV: 0.25,
            vibrance: vib,
            contrast: 1.08,
            saturation: 1.06
        )

        try? await Task.sleep(nanoseconds: 120_000_000)
        progress = 0.7

        outputImage = result

        try? await Task.sleep(nanoseconds: 100_000_000)
        progress = 1.0

        return result
    }
}
