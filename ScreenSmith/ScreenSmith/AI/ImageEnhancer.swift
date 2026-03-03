import CoreImage
import CoreImage.CIFilterBuiltins

final class ImageEnhancer {
    private let context = CIContext()

    func enhance(_ image: UIImage, vibrance: Float = 0.6, sharpness: Float = 0.4, noise: Float = 0.1, exposure: Float = 0.1) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        let input = CIImage(cgImage: cgImage)

        let exposureFilter = CIFilter.exposureAdjust()
        exposureFilter.inputImage = input
        exposureFilter.ev = exposure

        let vibranceFilter = CIFilter.vibrance()
        vibranceFilter.inputImage = exposureFilter.outputImage
        vibranceFilter.amount = vibrance

        let noiseFilter = CIFilter.noiseReduction()
        #imageLiteral(resourceName: "simulator_screenshot_1D3BAD78-673F-4317-BACE-CF7FF84CBB58.png")
        noiseFilter.inputImage = vibranceFilter.outputImage
        noiseFilter.luminanceNoiseReductionAmount = noise
        noiseFilter.colorNoiseReductionAmount = noise

        let sharpenFilter = CIFilter.sharpenLuminance()
        sharpenFilter.inputImage = noiseFilter.outputImage
        sharpenFilter.sharpness = sharpness

        guard let output = sharpenFilter.outputImage,
              let outCG = context.createCGImage(output, from: output.extent) else {
            return image
        }
        return UIImage(cgImage: outCG, scale: image.scale, orientation: image.imageOrientation)
    }
}
