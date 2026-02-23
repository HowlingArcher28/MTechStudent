//
//  ContentView.swift
//  horror app
//
//  Created by Zachary Jensen on 2/4/26.
//

import SwiftUI
import AVFoundation
import CoreMotion

struct ContentView: View {
    @State private var isArmed: Bool = true
    @State private var showIntro: Bool = true
    @State private var showJumpScare: Bool = false
    @State private var nextScareIn: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var flash: Bool = false
    @State private var ambientOpacity: Double = 1
    @State private var enableAmbient: Bool = true
    @State private var enableMotionScare: Bool = true
    @State private var showGlitch: Bool = false
    @State private var glitchTimer: Timer? = nil
    @State private var motionManager = CMMotionManager()

    var body: some View {
        ZStack {
            // Background: dark gradient with subtle animated opacity
            LinearGradient(colors: [.black, Color(red: 0.05, green: 0.0, blue: 0.0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "eye")
                        .font(.system(size: 120, weight: .ultraLight))
                        .foregroundStyle(Color.red.opacity(0.15))
                        .scaleEffect(1.05 + (flash ? 0.05 : 0))
                        .blur(radius: 2)
                        .opacity(ambientOpacity)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: ambientOpacity)
                        .onAppear { ambientOpacity = 0.7 }
                )

            // Main content
            VStack(spacing: 24) {
                Text("Do you dare?")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)
                    .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 0)

                Text("Keep your volume up. Random jump scares will occur.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Toggle(isOn: $isArmed) {
                    Text(isArmed ? "Armed" : "Disarmed")
                        .font(.headline)
                        .foregroundStyle(isArmed ? .red : .green)
                }
                .tint(.red)
                .padding(.horizontal)

                Toggle(isOn: $enableAmbient) {
                    Text("Ambient Heartbeat & Whispers")
                        .font(.subheadline)
                        .foregroundStyle(enableAmbient ? .white : .white.opacity(0.6))
                }
                .tint(.red)
                .padding(.horizontal)

                Toggle(isOn: $enableMotionScare) {
                    Text("Motion-Triggered Scares")
                        .font(.subheadline)
                        .foregroundStyle(enableMotionScare ? .white : .white.opacity(0.6))
                }
                .tint(.red)
                .padding(.horizontal)

                Button(action: triggerImmediateScare) {
                    Text("Summon Fear Now")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .shadow(color: .red.opacity(0.6), radius: 10)
                }

                if showIntro {
                    Text("Tap anywhere to begin...")
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.top, 8)
                } else if isArmed {
                    Text(nextScareLabel)
                        .foregroundStyle(.white.opacity(0.7))
                } else {
                    Text("Safe for now.")
                        .foregroundStyle(.white.opacity(0.7))
                }

                Spacer()

                Text("Warning: Loud sounds, flashing images, and haptics.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.bottom, 8)
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture { startIfNeeded() }

            // Jump scare overlay
            if showJumpScare {
                JumpScareView()
                    .transition(.opacity.combined(with: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showJumpScare = false
                            }
                        }
                    }
            }

            // Flash overlay for extra punch
            if flash {
                Color.white.opacity(0.9)
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
            
            if showGlitch {
                GlitchOverlay()
                    .transition(.opacity)
            }
        }
        .onAppear {
            scheduleNextScareRandomly()
            startAmbientIfNeeded()
            startMotionUpdatesIfNeeded()
            scheduleRandomGlitches()
        }
        .onDisappear { cancelTimer() }
        .onChange(of: isArmed) { _, newValue in
            if newValue { scheduleNextScareRandomly() } else { cancelTimer() }
        }
        .onChange(of: enableAmbient) { _, _ in
            startOrStopAmbient()
        }
        .onChange(of: enableMotionScare) { _, _ in
            startOrStopMotion()
        }
    }

    private var nextScareLabel: String {
        if nextScareIn <= 0 { return "Imminent..." }
        let seconds = Int(nextScareIn)
        return "Next scare in ~\(seconds)s"
    }

    private func startIfNeeded() {
        if showIntro {
            showIntro = false
            scheduleNextScareRandomly()
        }
    }

    private func scheduleNextScareRandomly() {
        guard isArmed else { return }
        cancelTimer()
        // Random delay between 8 and 25 seconds
        let delay = Double(Int.random(in: 8...25)) + Double.random(in: 0..<1)
        nextScareIn = delay
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { t in
            if nextScareIn <= 0 {
                t.invalidate()
                triggerImmediateScare()
            } else {
                nextScareIn -= 0.2
            }
        }
    }

    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
        glitchTimer?.invalidate()
        glitchTimer = nil
    }

    private func triggerImmediateScare() {
        guard isArmed else { return }
        // Flash white quickly
        withAnimation(.easeIn(duration: 0.05)) { flash = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            withAnimation(.easeOut(duration: 0.1)) { flash = false }
        }

        // Show scary overlay
        withAnimation(.easeIn(duration: 0.05)) {
            showJumpScare = true
        }

        // Play sound and haptics
        AudioManager.shared.playJumpScareSound()
        HapticsManager.shared.intenseShock()

        // Schedule next
        scheduleNextScareRandomly()
    }
    
    private func startAmbientIfNeeded() {
        if enableAmbient { AudioManager.shared.startAmbientLoop() }
    }

    private func startOrStopAmbient() {
        if enableAmbient {
            AudioManager.shared.startAmbientLoop()
        } else {
            AudioManager.shared.stopAmbientLoop()
        }
    }

    private func startMotionUpdatesIfNeeded() {
        guard enableMotionScare else { return }
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 30.0
            motionManager.startAccelerometerUpdates(to: .main) { data, _ in
                guard let a = data?.acceleration else { return }
                let magnitude = sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
                if magnitude > 2.2 { // sudden movement threshold
                    triggerImmediateScare()
                }
            }
        }
    }

    private func startOrStopMotion() {
        if enableMotionScare {
            startMotionUpdatesIfNeeded()
        } else {
            motionManager.stopAccelerometerUpdates()
        }
    }

    private func scheduleRandomGlitches() {
        glitchTimer?.invalidate()
        glitchTimer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 6...14), repeats: true) { _ in
            withAnimation(.easeIn(duration: 0.05)) { showGlitch = true }
            AudioManager.shared.playGlitch()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeOut(duration: 0.1)) { showGlitch = false }
            }
        }
    }
}

struct JumpScareView: View {
    @State private var scale: CGFloat = 0.9
    @State private var rotate: Double = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            // Use a bundled scary image named "jumpscare". Fallback to a system symbol if missing.
            Group {
                if let uiImage = UIImage(named: "jumpscare") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "face.dashed")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .black)
                }
            }
            .shadow(color: .red, radius: 30)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotate))
            .onAppear {
                withAnimation(.easeIn(duration: 0.06)) { scale = 1.2 }
                withAnimation(.easeIn(duration: 0.08)) { rotate = Double(Int.random(in: -6...6)) }
            }
        }
        .statusBarHidden(true)
    }
}

struct GlitchOverlay: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 0) {
                ForEach(0..<12, id: \.self) { i in
                    Rectangle()
                        .fill(i % 2 == 0 ? Color.red.opacity(0.25) : Color.white.opacity(0.15))
                        .frame(height: CGFloat(Int.random(in: 8...20)))
                        .offset(x: i % 3 == 0 ? offset : -offset)
                        .blendMode(.screen)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 0.12)) { offset = 30 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                offset = 0
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    ContentView()
}
