//
//  ImportView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI
import PhotosUI

struct ImportView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var selectedItem: PhotosPickerItem?

    func didSelect(image: UIImage) {
        navigationManager.goToEnhance(image: image)
    }
    var body: some View {
        ZStack {
            NeonBackground()

            VStack(spacing: 20) {

                Text("ScreenSmith")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .neonGlow(color: NeonColors.neonCyan, radius: 12, intensity: 0.45)

                Text("Import")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.8))

                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    NeonCard(color: NeonColors.neonBlue) {

                        VStack(spacing: 12) {

                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)

                            Text("Select Photo")

                        }
                        .frame(maxWidth: .infinity, minHeight: 140)

                    }
                }
                .onChange(of: selectedItem) { newItem in
                    guard let newItem = newItem else { return }
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            didSelect(image: uiImage)
                        }
                    }
                }

                NeonCard(color: NeonColors.neonPurple) {

                    VStack(spacing: 16) {

                        ToggleRow(
                            title: "Smart Crop",
                            subtitle: "Automatically crop to fit your screen."
                        )

                        ToggleRow(
                            title: "Auto Enhance",
                            subtitle: "Automatically enhance photo quality."
                        )

                    }

                }

                Spacer()

            }
            .padding()
        }
    }
}
