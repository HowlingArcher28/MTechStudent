import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

final class ImageEnhancer {
    private let context = CIContext()

    // Enhance with optional upscaling. Scale > 1.0 will upscale using Lanczos.
    func enhance(_ image: UIImage,
                 exposure: Float = 0.2,
                 vibrance: Float = 0.9,
                 sharpness: Float = 0.8,
                 noise: Float = 0.2,
                 contrast: Float = 1.12,
                 saturation: Float = 1.1,
                 upscale: Bool = true,
                 scaleFactor: CGFloat = 2.0) -> UIImage {

        guard let cgImage = image.cgImage else { return image }
        var current = CIImage(cgImage: cgImage)

        // Optional: Upscale early to give filters more pixels to work with
        if upscale, scaleFactor > 1.0 {
            let lanczos = CIFilter.lanczosScaleTransform()
            lanczos.inputImage = current
            lanczos.scale = Float(scaleFactor)
            lanczos.aspectRatio = 1.0
            if let out = lanczos.outputImage { current = out } // if fails, continue with original size
        }

        // 1) Exposure
        let exposureFilter = CIFilter.exposureAdjust()
        exposureFilter.inputImage = current
        exposureFilter.ev = exposure
        guard let expOut = exposureFilter.outputImage else { return image }

        // 2) Vibrance
        let vibranceFilter = CIFilter.vibrance()
        vibranceFilter.inputImage = expOut
        vibranceFilter.amount = vibrance
        guard let vibOut = vibranceFilter.outputImage else { return image }

        // 3) Noise reduction
        let noiseFilter = CIFilter.noiseReduction()
        noiseFilter.inputImage = vibOut
        noiseFilter.noiseLevel = noise
        noiseFilter.sharpness = 0.4
        guard let noiseOut = noiseFilter.outputImage else { return image }

        // 4) Sharpen
        let sharpenFilter = CIFilter.sharpenLuminance()
        sharpenFilter.inputImage = noiseOut
        sharpenFilter.sharpness = sharpness
        guard let sharpOut = sharpenFilter.outputImage else { return image }

        // 5) Color controls
        let colorControls = CIFilter.colorControls()
        colorControls.inputImage = sharpOut
        colorControls.contrast = contrast
        colorControls.saturation = saturation
        guard let finalOut = colorControls.outputImage else { return image }

        guard let outCG = context.createCGImage(finalOut, from: finalOut.extent) else { return image }
        return UIImage(cgImage: outCG, scale: image.scale, orientation: image.imageOrientation)
    }
}
