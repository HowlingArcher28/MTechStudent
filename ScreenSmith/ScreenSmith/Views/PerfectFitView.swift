//
//  PerfectFitView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI
import Vision
import CoreImage
import UIKit
import Photos
import PhotosUI

struct PerfectFitView: View {

    let image: UIImage
    @State private var croppedImage: UIImage?
    @State private var isProcessing: Bool = false
    @State private var saveMessage: String?

    private enum AspectChoice: String, CaseIterable, Identifiable {
        case iphone = "iPhone (19.5:9)"
        case ipad = "iPad (4:3)"
        case square = "Square (1:1)"
        case custom = "Custom"
        var id: String { rawValue }
    }

    @State private var selectedAspect: AspectChoice = .iphone
    @State private var customWidth: String = "19.5"
    @State private var customHeight: String = "9"

    private var targetAspect: CGFloat {
        switch selectedAspect {
        case .iphone: return 19.5/9.0
        case .ipad: return 4.0/3.0
        case .square: return 1.0
        case .custom:
            let w = Double(customWidth) ?? 1
            let h = Double(customHeight) ?? 1
            return CGFloat(max(w, 0.0001) / max(h, 0.0001))
        }
    }

    var body: some View {

        VStack(spacing: 20) {

            Text("Perfect Fit")
                .font(.title)

            Picker("Aspect", selection: $selectedAspect) {
                ForEach(AspectChoice.allCases) { choice in
                    Text(choice.rawValue).tag(choice)
                }
            }
            .pickerStyle(.segmented)

            if selectedAspect == .custom {
                HStack(spacing: 12) {
                    TextField("W", text: $customWidth)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 80)
                    Text(":")
                    TextField("H", text: $customHeight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 80)
                    Spacer()
                }
            }

            GlassCard {
                Image(uiImage: croppedImage ?? image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
            }

            if isProcessing {
                ProgressView("Applying Smart Crop...")
                    .tint(.blue)
            }

            ToggleRow(
                title: "Smart Crop",
                subtitle: "Accurately fits your screen size."
            )

            PrimaryButton(title: "Apply Smart Crop")
                .onTapGesture {
                    applySmartCrop()
                }

            PrimaryButton(title: "Save to Gallery")
                .onTapGesture {
                    saveToGallery()
                }

            if let saveMessage = saveMessage {
                Text(saveMessage)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer()

        }
        .padding()
        .task {
            applySmartCrop()
        }
    }

    private func applySmartCrop() {
        isProcessing = true
        let current = croppedImage ?? image
        DispatchQueue.global(qos: .userInitiated).async {
            let cropper = SmartCropper()
            let result = cropper.crop(image: current, targetAspect: targetAspect)
            DispatchQueue.main.async {
                self.croppedImage = result
                self.isProcessing = false
            }
        }
    }
    private func saveToGallery() {
        let toSave = croppedImage ?? image
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized || status == .limited else {
                DispatchQueue.main.async { self.saveMessage = "Photos access denied." }
                return
            }
            var placeholder: PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest.creationRequestForAsset(from: toSave)
                placeholder = request.placeholderForCreatedAsset
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    if success && placeholder != nil {
                        self.saveMessage = "Saved to Photos."
                    } else {
                        self.saveMessage = "Save failed: \(error?.localizedDescription ?? "Unknown error")"
                    }
                }
            })
        }
    }
}

