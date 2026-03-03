import Foundation
import SwiftUI
import Combine

@MainActor
final class ImagePipeline: ObservableObject {
    @Published var isProcessing: Bool = false
    @Published var progress: Double = 0
    @Published var lastError: Error?

    func process(_ image: UIImage) async {
        isProcessing = true
        progress = 0
        defer { isProcessing = false }

        for step in 1...5 {
            try? await Task.sleep(nanoseconds: 250_000_000)
            progress = Double(step) / 5.0
        }
    }
}
