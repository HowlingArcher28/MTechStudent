import SwiftUI
import UIKit

struct PerfectFitView: View {
    let image: UIImage
    @State private var workingImage: UIImage
    @State private var smartCrop = true
    @State private var device = "iPhone 14 Pro"

    init(image: UIImage) {
        self.image = image
        _workingImage = State(initialValue: image)
    }

    private var targetAspect: CGFloat {
        switch device {
        // iPhone
        case "iPhone 17 Pro": return 1179.0/2556.0
        case "iPhone 17 Pro Max": return 1290.0/2796.0
        case "iPhone 17": return 1170.0/2532.0
        case "iPhone 17 Plus": return 1290.0/2796.0
        case "iPhone 16 Pro": return 1179.0/2556.0
        case "iPhone 16 Pro Max": return 1290.0/2796.0
        case "iPhone 16": return 1170.0/2532.0
        case "iPhone 16 Plus": return 1290.0/2796.0
        case "iPhone 15 Pro": return 1179.0/2556.0
        case "iPhone 15 Pro Max": return 1290.0/2796.0
        case "iPhone 15": return 1170.0/2532.0
        case "iPhone 15 Plus": return 1290.0/2796.0
        case "iPhone 14 Pro": return 1179.0/2556.0
        case "iPhone 14": return 1170.0/2532.0
        case "iPhone SE (2nd/3rd Gen)": return 750.0/1334.0
        // iPad
        case "iPad Pro 12.9": return 2048.0/2732.0
        case "iPad Pro 11": return 1668.0/2388.0
        case "iPad Air 10.9": return 1640.0/2360.0
        // Social banners / media
        case "LinkedIn Banner (1584x396)": return 1584.0/396.0   // 4:1
        case "X Header (1500x500)": return 1500.0/500.0           // 3:1
        case "Facebook Cover (820x312)": return 820.0/312.0       // ~2.628:1
        case "YouTube Thumbnail (1280x720)": return 1280.0/720.0  // 16:9
        case "Instagram Story (1080x1920)": return 1080.0/1920.0  // 9:16
        case "TikTok (1080x1920)": return 1080.0/1920.0           // 9:16
        // Desktop / Laptop
        case "Desktop 16:9": return 16.0/9.0
        case "Desktop 16:10": return 16.0/10.0
        case "MacBook Pro 14": return 3024.0/1964.0
        default:
            return 1179.0/2556.0
        }
    }

    var body: some View {
        ZStack {
            NeonBackground()

            ScrollView {
                VStack(spacing: 20) {
                    header
                    optionsCard
                    ctaButton
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Perfect Fit")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                    .neonGlow(color: NeonColors.neonBlue, radius: 12, intensity: 0.45)
            }
        }
    }

    var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Perfect Fit")
                .font(.title.bold())
                .foregroundStyle(.white)
                .neonGlow(color: NeonColors.neonBlue, radius: 18, intensity: 0.5)
            Text("Make your photo fit your device screen size perfectly.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
        }
    }

    var optionsCard: some View {
        NeonCard(color: NeonColors.neonPurple) {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.03))
                    .overlay(
                        Image(uiImage: workingImage)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .cornerRadius(12)
                            .padding(8)
                    )
                    .frame(height: 200)
                    .neonGlow(color: NeonColors.neonBlue, radius: 12, intensity: 0.3)

                Text("Options")
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.headline)

                Toggle(isOn: $smartCrop) {
                    Text("Smart Crop")
                        .foregroundStyle(.white.opacity(0.9))
                }
                .tint(NeonColors.neonBlue)

                HStack {
                    Text("Device Size")
                        .foregroundStyle(.white.opacity(0.9))
                    Spacer()
                    Menu(device) {
                        // iPhone
                        Button("iPhone 17 Pro") { device = "iPhone 17 Pro" }
                        Button("iPhone 17 Pro Max") { device = "iPhone 17 Pro Max" }
                        Button("iPhone 17") { device = "iPhone 17" }
                        Button("iPhone 17 Plus") { device = "iPhone 17 Plus" }
                        Button("iPhone 16 Pro") { device = "iPhone 16 Pro" }
                        Button("iPhone 16 Pro Max") { device = "iPhone 16 Pro Max" }
                        Button("iPhone 16") { device = "iPhone 16" }
                        Button("iPhone 16 Plus") { device = "iPhone 16 Plus" }
                        Button("iPhone 15 Pro") { device = "iPhone 15 Pro" }
                        Button("iPhone 15 Pro Max") { device = "iPhone 15 Pro Max" }
                        Button("iPhone 15") { device = "iPhone 15" }
                        Button("iPhone 15 Plus") { device = "iPhone 15 Plus" }
                        Button("iPhone 14 Pro") { device = "iPhone 14 Pro" }
                        Button("iPhone 14") { device = "iPhone 14" }
                        Button("iPhone SE (2nd/3rd Gen)") { device = "iPhone SE (2nd/3rd Gen)" }
                        Divider()
                        // iPad
                        Button("iPad Pro 12.9") { device = "iPad Pro 12.9" }
                        Button("iPad Pro 11") { device = "iPad Pro 11" }
                        Button("iPad Air 10.9") { device = "iPad Air 10.9" }
                        Divider()
                        // Social banners / media
                        Button("LinkedIn Banner (1584x396)") { device = "LinkedIn Banner (1584x396)" }
                        Button("X Header (1500x500)") { device = "X Header (1500x500)" }
                        Button("Facebook Cover (820x312)") { device = "Facebook Cover (820x312)" }
                        Button("YouTube Thumbnail (1280x720)") { device = "YouTube Thumbnail (1280x720)" }
                        Button("Instagram Story (1080x1920)") { device = "Instagram Story (1080x1920)" }
                        Button("TikTok (1080x1920)") { device = "TikTok (1080x1920)" }
                        Divider()
                        // Desktop / Laptop
                        Button("Desktop 16:9") { device = "Desktop 16:9" }
                        Button("Desktop 16:10") { device = "Desktop 16:10" }
                        Button("MacBook Pro 14") { device = "MacBook Pro 14" }
                    }
                    .foregroundStyle(.white)
                }

                Button {
                    if smartCrop {
                        let cropper = SmartCropper()
                        workingImage = cropper.crop(image: image, targetAspect: targetAspect)
                    } else {
                        workingImage = image
                    }
                } label: {
                    Label("Apply Crop", systemImage: "crop")
                }
                .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue))
            }
        }
    }

    var ctaButton: some View {
        Button {
            // Save cropped result
        } label: {
            HStack {
                Spacer()
                Text("Save to Gallery")
                Spacer()
            }
        }
        .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue, cornerRadius: 18))
    }
}

#Preview {
    NavigationStack { PerfectFitView(image: UIImage(systemName: "photo")!) }
}
