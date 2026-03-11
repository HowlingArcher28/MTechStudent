import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

final class ImageEnhancer {
    private let context = CIContext()

    /// Enhances and de-pixelates a low-res image.
    /// - Parameters:
    ///   - image: Input image.
    ///   - upscaleFactor: Lanczos upscale factor (e.g., 3.0 for strong de-pixelation).
    ///   - medianRadius: Median filter radius for block smoothing.
    ///   - noiseLevel: Noise reduction level (0-1).
    ///   - noiseSharpness: Edge preservation for noise reduction (0-1).
    ///   - unsharpRadius: Unsharp mask radius for detail restoration.
    ///   - unsharpIntensity: Unsharp mask intensity.
    ///   - finalDownscale: Optional final scale to slightly reduce size and blend artifacts (e.g., 0.75-0.9).
    ///   - exposureEV, vibrance, contrast, saturation: Color tweaks for perceived quality.
    func enhance(_ image: UIImage,
                 upscaleFactor: CGFloat = 4.0,
                 medianRadius: Float = 1.0,
                 noiseLevel: Float = 0.02,
                 noiseSharpness: Float = 0.35,
                 unsharpRadius: Float = 1.2,
                 unsharpIntensity: Float = 1.1,
                 finalDownscale: CGFloat = 0.92,
                 exposureEV: Float = 0.35,
                 vibrance: Float = 0.25,
                 contrast: Float = 1.08,
                 saturation: Float = 1.05) -> UIImage {

        guard let cgImage = image.cgImage else { return image }
        var current = CIImage(cgImage: cgImage)

        // 1) Strong upscale to reduce visible block edges
        if upscaleFactor > 1.0 {
            let lanczos = CIFilter.lanczosScaleTransform()
            lanczos.inputImage = current
            lanczos.scale = Float(upscaleFactor)
            lanczos.aspectRatio = 1.0
            if let out = lanczos.outputImage { current = out }
        }

        // 2) Median filter to smooth pixel blocks while preserving edges
        let median = CIFilter.median()
        median.inputImage = current
        if let out = median.outputImage { current = out }

        // 3) Optional: small Gaussian blur to further blend blockiness
        if medianRadius > 0.0 {
            let gaussian = CIFilter.gaussianBlur()
            gaussian.inputImage = current
            gaussian.radius = medianRadius
            if let out = gaussian.outputImage { current = out }
        }

        // 4) Noise reduction (edge-preserving)
        let noiseFilter = CIFilter.noiseReduction()
        noiseFilter.inputImage = current
        noiseFilter.noiseLevel = noiseLevel
        noiseFilter.sharpness = noiseSharpness
        if let out = noiseFilter.outputImage { current = out }

        // 5) Unsharp mask to bring back detail after smoothing
        let unsharp = CIFilter.unsharpMask()
        unsharp.inputImage = current
        unsharp.radius = unsharpRadius
        unsharp.intensity = unsharpIntensity
        if let out = unsharp.outputImage { current = out }

        // 6) Color tweaks to improve perceived quality
        let exposure = CIFilter.exposureAdjust()
        exposure.inputImage = current
        exposure.ev = exposureEV
        if let out = exposure.outputImage { current = out }

        let vib = CIFilter.vibrance()
        vib.inputImage = current
        vib.amount = vibrance
        if let out = vib.outputImage { current = out }

        let color = CIFilter.colorControls()
        color.inputImage = current
        color.contrast = contrast
        color.saturation = saturation
        if let out = color.outputImage { current = out }

        // 7) Optional gentle downscale to blend remaining jaggies
        if finalDownscale > 0.0, finalDownscale < 1.0 {
            let lanczosDown = CIFilter.lanczosScaleTransform()
            lanczosDown.inputImage = current
            lanczosDown.scale = Float(finalDownscale)
            lanczosDown.aspectRatio = 1.0
            if let out = lanczosDown.outputImage { current = out }
        }

        guard let outCG = context.createCGImage(current, from: current.extent) else { return image }
        return UIImage(cgImage: outCG, scale: image.scale, orientation: image.imageOrientation)
    }
}
