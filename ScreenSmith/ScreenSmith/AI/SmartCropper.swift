import Vision
import CoreImage
import UIKit

struct SmartCropper {
    func crop(image: UIImage, targetAspect: CGFloat) -> UIImage {
        guard let cgImage = image.cgImage else { return image }

        // Step 1: Detect faces or salient regions
        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])

        let faces = (request.results) ?? []
        // Convert VN rects (normalized) to image-space rects
        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        let focusRect = faces.first.map { face in
            convertFromNormalizedRect(face.boundingBox, imageSize: imageSize)
        } ?? CGRect(origin: .zero, size: imageSize)

        // Step 2: Compute crop rect for target aspect ratio around focusRect
        let cropRect = cropRectAround(focusRect: focusRect, in: CGRect(origin: .zero, size: imageSize), targetAspect: targetAspect)

        // Step 3: Perform crop
        if let croppedCG = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: croppedCG, scale: image.scale, orientation: image.imageOrientation)
        } else {
            return image
        }
    }

    private func convertFromNormalizedRect(_ rect: CGRect, imageSize: CGSize) -> CGRect {
        // VN uses origin at bottom-left in normalized coords
        let x = rect.origin.x * imageSize.width
        let height = rect.size.height * imageSize.height
        let y = (1 - rect.origin.y - rect.size.height) * imageSize.height
        let width = rect.size.width * imageSize.width
        return CGRect(x: x, y: y, width: width, height: height)
    }

    private func cropRectAround(focusRect: CGRect, in bounds: CGRect, targetAspect: CGFloat) -> CGRect {
        // Compute a crop rect that contains focusRect and matches targetAspect,
        // constrained within bounds. This can be refined, but here’s a simple approach:
        var crop = focusRect

        let focusAspect = focusRect.width / focusRect.height
        if focusAspect > targetAspect {
            // too wide -> expand height
            let targetHeight = focusRect.width / targetAspect
            let delta = (targetHeight - focusRect.height) / 2
            crop = crop.insetBy(dx: 0, dy: -delta)
        } else {
            // too tall -> expand width
            let targetWidth = focusRect.height * targetAspect
            let delta = (targetWidth - focusRect.width) / 2
            crop = crop.insetBy(dx: -delta, dy: 0)
        }

        // Clamp inside bounds
        crop = crop.intersection(bounds)
        // If clamp changed aspect, re-center and adjust:
        let currentAspect = crop.width / crop.height
        if abs(currentAspect - targetAspect) > 0.01 {
            // Adjust width or height to match aspect while keeping center
            let center = CGPoint(x: crop.midX, y: crop.midY)
            var width = crop.width
            var height = crop.height
            if currentAspect > targetAspect {
                // too wide -> reduce width
                width = height * targetAspect
            } else {
                // too tall -> reduce height
                height = width / targetAspect
            }
            crop = CGRect(x: center.x - width/2, y: center.y - height/2, width: width, height: height)
            crop = crop.intersection(bounds)
        }

        return crop
    }
}
