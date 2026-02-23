import AVFoundation
import SwiftUI

final class AudioManager: NSObject {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?
    private var ambientPlayer: AVAudioPlayer?

    func playJumpScareSound() {
        // Try to load a bundled sound named "jumpscare.wav" or "jumpscare.mp3"
        let candidates = ["jumpscare", "scream", "shock"]
        for name in candidates {
            if let url = Bundle.main.url(forResource: name, withExtension: "wav") ?? Bundle.main.url(forResource: name, withExtension: "mp3") {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                    try AVAudioSession.sharedInstance().setActive(true)
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.volume = 1.0
                    player?.prepareToPlay()
                    player?.play()
                    return
                } catch {
                    print("Audio error: \(error)")
                }
            }
        }
        print("Jump scare sound not found. Add jumpscare.wav to the app bundle.")
    }

    func startAmbientLoop() {
        // Look for heartbeat or whisper loops
        let candidates = [("heartbeat", "wav"), ("heartbeat", "mp3"), ("whispers", "wav"), ("whispers", "mp3")]
        for (name, ext) in candidates {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
                    try AVAudioSession.sharedInstance().setActive(true)
                    let p = try AVAudioPlayer(contentsOf: url)
                    p.numberOfLoops = -1
                    p.volume = 0.35
                    p.prepareToPlay()
                    p.play()
                    ambientPlayer = p
                    return
                } catch {
                    print("Ambient audio error: \(error)")
                }
            }
        }
        print("Ambient loop not found. Add heartbeat.wav or whispers.wav to the bundle.")
    }

    func stopAmbientLoop() {
        ambientPlayer?.stop()
        ambientPlayer = nil
    }

    func playGlitch() {
        // Optional short glitch sound
        if let url = Bundle.main.url(forResource: "glitch", withExtension: "wav") ?? Bundle.main.url(forResource: "glitch", withExtension: "mp3") {
            do {
                let p = try AVAudioPlayer(contentsOf: url)
                p.volume = 0.5
                p.prepareToPlay()
                p.play()
            } catch {
                print("Glitch audio error: \(error)")
            }
        }
    }

    func stop() {
        player?.stop()
        player = nil
    }
}

