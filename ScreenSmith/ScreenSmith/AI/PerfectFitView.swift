import SwiftUI

struct PerfectFitView: View {
    @State private var smartCrop = true
    @State private var device = "iPhone 14 Pro"

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
                        Button("iPhone 14 Pro") { device = "iPhone 14 Pro" }
                        Button("iPhone 15 Pro") { device = "iPhone 15 Pro" }
                        Button("iPad Pro 12.9") { device = "iPad Pro 12.9" }
                    }
                    .foregroundStyle(.white)
                }
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
    NavigationStack { PerfectFitView() }
}
