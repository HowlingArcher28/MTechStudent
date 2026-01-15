//
//  PhotoScrollView.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI
import UIKit

struct PhotoScrollView: View {
    var journalEntry: JournalEntry
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImage: Image? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                // Existing photos
                ForEach(journalEntry.photos) { photo in
                    if let uiImage = UIImage(data: photo.data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.quaternary)
                            Image(systemName: "photo.fill")
                                .imageScale(.large)
                                .foregroundStyle(.secondary)
                        }
                        .frame(width: 150, height: 150)
                    }
                }
                
                // Photo Picker appears at end of list of photos
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    VStack(spacing: 8) {
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        
                        Text("Add Photos...")
                            .font(.footnote)
                    }
                    .frame(width: 150, height: 150)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .onChange(of: selectedItems) {
                    loadTransferable()
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    /// Pulls the image data for each selected photo
    func loadTransferable() {
        for item in selectedItems {
            item.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if let data = data {
                            let newPhoto = Photo(data: data)
                            journalEntry.photos.append(newPhoto)
                            do {
                                try modelContext.save()
                            } catch {
                                #if DEBUG
                                print("Failed to save after adding photo:", error)
                                #endif
                            }
                        }
                    case .failure(let error):
                        print("Failed to load image: \(error)")
                    }
                }
            }
        }
    }
}

