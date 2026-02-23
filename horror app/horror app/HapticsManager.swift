import CoreHaptics
import UIKit

final class HapticsManager {
    static let shared = HapticsManager()
    private var engine: CHHapticEngine?

    private init() {
        prepare()
    }

    private func prepare() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptics error: \(error)")
        }
    }

    func intenseShock() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [sharpness, intensity], relativeTime: 0)
        let event2 = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity], relativeTime: 0.02, duration: 0.2)
        do {
            let pattern = try CHHapticPattern(events: [event, event2], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Haptics pattern error: \(error)")
        }
    }
}
