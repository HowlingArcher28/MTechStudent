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
    @State private var showingAllScreens = false

    func didSelect(image: UIImage) {
        navigationManager.goToEnhance(image: image)
    }
    var body: some View {

        VStack(spacing: 20) {

            Text("ScreenSmith")
                .font(.largeTitle)
                .foregroundColor(.blue)

            Text("Import")
                .font(.title2)

            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                GlassCard {

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

            GlassCard {

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
        .background(
            LinearGradient(
                colors: [
                    Color.black,
                    Color.black,
                    Color.blue.opacity(5),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("All Screens") {
                    showingAllScreens = true
                }
            }
        }
        .sheet(isPresented: $showingAllScreens) {
            AllScreensView()
                .environmentObject(navigationManager)
        }
    }
}
