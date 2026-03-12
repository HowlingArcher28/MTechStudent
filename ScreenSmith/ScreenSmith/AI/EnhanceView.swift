import SwiftUI

struct EnhanceView: View {
    @State private var smartCrop = true
    @State private var autoEnhance = true
    @State private var sharpness: Double = 0.75
    @State private var vibrance: Double = 0.30
    @State private var blurBackground = true

    var body: some View {
        ZStack {
            NeonBackground()

            ScrollView {
                VStack(spacing: 20) {
                    header
                    previewCard
                    optionsCard
                    adjustmentsCard
                    ctaButton
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Enhance")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                    .neonGlow(color: NeonColors.neonCyan, radius: 12, intensity: 0.45)
            }
        }
    }

    // MARK: - Header
    var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("AI Upscaling")
                .font(.title.bold())
                .foregroundStyle(.white)
                .neonGlow(color: NeonColors.neonCyan, radius: 18, intensity: 0.5)
            Text("Improve clarity and detail while preserving natural look.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
        }
    }

    // MARK: - Preview / Import
    var previewCard: some View {
        NeonCard(color: NeonColors.neonBlue) {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.03))
                    .overlay(
                        ZStack {
                            Image(systemName: "photo")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundStyle(.white)
                                .neonGlow(color: NeonColors.neonBlue, radius: 18, intensity: 0.6)
                            VStack {
                                Spacer()
                                Text("Drag & drop or tap to select a photo")
                                    .font(.footnote)
                                    .foregroundStyle(.white.opacity(0.7))
                                    .padding(.bottom, 10)
                            }
                        }
                    )
                    .frame(height: 200)
                    .neonGlow(color: NeonColors.neonBlue, radius: 16, intensity: 0.35)

                HStack(spacing: 12) {
                    Button {
                        // Import from Photos
                    } label: {
                        Label("Photos", systemImage: "photo.on.rectangle")
                    }
                    .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue))

                    Button {
                        // Import from Files
                    } label: {
                        Label("Files", systemImage: "folder")
                    }
                    .buttonStyle(NeonButtonStyle(color: NeonColors.neonPurple))
                }
            }
        }
    }

    // MARK: - Options
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

                Toggle(isOn: $autoEnhance) {
                    Text("Auto Enhance")
                        .foregroundStyle(.white.opacity(0.9))
                }
                .tint(NeonColors.neonGreen)

                Toggle(isOn: $blurBackground) {
                    Text("Blur Background")
                        .foregroundStyle(.white.opacity(0.9))
                }
                .tint(NeonColors.neonCyan)
            }
        }
    }

    // MARK: - Adjustments
    var adjustmentsCard: some View {
        NeonCard(color: NeonColors.neonBlue) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Adjustments")
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.headline)

                VStack(spacing: 14) {
                    NeonSlider(color: NeonColors.neonBlue, value: sharpness) {
                        HStack {
                            Text("Sharpness")
                            Spacer()
                            Text("\(Int(sharpness * 100))")
                        }
                    }
                    Slider(value: $sharpness, in: 0...1)
                        .tint(NeonColors.neonBlue)

                    NeonSlider(color: NeonColors.neonPurple, value: vibrance) {
                        HStack {
                            Text("Vibrance")
                            Spacer()
                            Text("\(Int(vibrance * 100))")
                        }
                    }
                    Slider(value: $vibrance, in: 0...1)
                        .tint(NeonColors.neonPurple)
                }
            }
        }
    }

    // MARK: - CTA
    var ctaButton: some View {
        Button {
            // Run enhancement / save result
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
    NavigationStack { EnhanceView() }
}
