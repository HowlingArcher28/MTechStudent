import SwiftUI
import UIKit

struct EnhanceView: View {
    let image: UIImage
    @EnvironmentObject var pipeline: ImagePipeline
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var sharpness: Double = 0.75
    @State private var vibrance: Double = 0.30

    @State private var enhancedImage: UIImage?
    @State private var splitPosition: CGFloat = 0.5 // 0...1 for before/after slider
    @State private var showPreviewHint: Bool = true

    var body: some View {
        ZStack {
            NeonBackground()

            ScrollView {
                VStack(spacing: 20) {
                    header
                    previewCard
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
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    ZStack {
                        // After (enhanced) image in the back
                        if let enhanced = enhancedImage {
                            Image(uiImage: enhanced)
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: height)
                                .clipped()
                        } else {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: height)
                                .clipped()
                        }

                        // Before image masked to the split position (left side)
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height)
                            .clipped()
                            .mask(
                                HStack(spacing: 0) {
                                    Rectangle().frame(width: max(0, min(width, width * splitPosition)), height: height)
                                    Spacer(minLength: 0)
                                }
                            )

                        // Divider line
                        Rectangle()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 2)
                            .position(x: max(0, min(width, width * splitPosition)), y: height / 2)
                            .shadow(color: .black.opacity(0.4), radius: 2)

                        // Drag handle
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 28, height: 28)
                                .shadow(color: .black.opacity(0.3), radius: 3)
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.black.opacity(0.8))
                        }
                        .position(x: max(14, min(width - 14, width * splitPosition)), y: height / 2)

                        // Before/After labels
                        HStack {
                            Text("Before")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.white.opacity(0.85))
                                .padding(6)
                                .background(Color.black.opacity(0.25))
                                .clipShape(Capsule())
                                .padding([.leading, .top], 10)
                            Spacer()
                            if enhancedImage != nil {
                                Text("After")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.white.opacity(0.85))
                                    .padding(6)
                                    .background(Color.black.opacity(0.25))
                                    .clipShape(Capsule())
                                    .padding([.trailing, .top], 10)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                        if showPreviewHint {
                            VStack {
                                Text("Drag to compare")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.white.opacity(0.9))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.black.opacity(0.35))
                                    .clipShape(Capsule())
                                    .padding(.bottom, 12)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .transition(.opacity)
                        }
                    }
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let x = value.location.x / max(1, width)
                                splitPosition = max(0, min(1, x))
                                withAnimation(.easeOut(duration: 0.2)) { showPreviewHint = false }
                            }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .frame(height: 480)

                VStack(spacing: 8) {
                    ProgressView(value: pipeline.progress)
                        .tint(NeonColors.neonBlue)
                        .opacity(pipeline.isProcessing ? 1 : 0)
                    Button {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        withAnimation(.easeOut(duration: 0.2)) { showPreviewHint = false }
                        Task {
                            let result = await pipeline.enhance(image, sharpness: sharpness, vibrance: vibrance, autoEnhance: true)
                            enhancedImage = result
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                splitPosition = 0.75
                            }
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        if pipeline.isProcessing {
                            HStack(spacing: 8) {
                                ProgressView()
                                Text("Upscaling…")
                            }
                        } else {
                            HStack(spacing: 8) {
                                Image(systemName: "wand.and.stars")
                                Text("AI Upscaling")
                            }
                        }
                    }
                    .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue))
                    .disabled(pipeline.isProcessing)
                }
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
                    HStack {
                        Text("Sharpness")
                        Spacer()
                        Text("\(Int(sharpness * 100))")
                    }
                    Slider(value: $sharpness, in: 0...1)
                        .tint(NeonColors.neonBlue)

                    HStack {
                        Text("Vibrance")
                        Spacer()
                        Text("\(Int(vibrance * 100))")
                    }
                    Slider(value: $vibrance, in: 0...1)
                        .tint(NeonColors.neonPurple)
                }
                Text("Tip: Adjust sliders, then tap AI Upscaling to re-enhance.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
    }

    // MARK: - CTA
    var ctaButton: some View {
        Button {
            let next = enhancedImage ?? image
            navigationManager.goToPerfectFit(image: next)
        } label: {
            HStack {
                Spacer()
                Text("Continue to Image Cropping")
                Spacer()
            }
        }
        .buttonStyle(NeonButtonStyle(color: NeonColors.neonBlue, cornerRadius: 18))
    }
}

#Preview {
    NavigationStack { EnhanceView(image: UIImage(systemName: "photo")!) }
        .environmentObject(ImagePipeline())
        .environmentObject(NavigationManager())
}

