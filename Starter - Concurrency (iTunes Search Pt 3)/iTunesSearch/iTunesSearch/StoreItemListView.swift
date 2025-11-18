//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

import SwiftUI
import AVFoundation

@Observable
class StoreItemListViewModel {
    
    var items: [StoreItem] = []
    
    var searchText = ""
    var selectedMediaType: MediaType = .music

   
    let controller = StoreItemController()

    var previewTask: Task<Void, Never>? = nil
    var previewPlayer: AVPlayer? = nil

    func fetchMatchingItems() {
        let term = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !term.isEmpty else {
            items = []
            return
        }

        let query: [String: String] = [
            "term": term,
            "media": selectedMediaType.apiValue,
            "limit": "25",
            "lang": "en_us"
        ]

        Task {
            do {
                let fetched = try await controller.fetchItems(matching: query)
                await MainActor.run {
                    self.items = fetched
                }
            } catch {
                print("Error fetching items: \(error)")
            }
        }
    }
}

struct StoreItemListView: View {
    @State private var viewModel = StoreItemListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Media Type", selection: $viewModel.selectedMediaType) {
                    ForEach(MediaType.allCases, id: \.self) { mediaType in
                        Text(mediaType.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top])

                HStack {
                    TextField("Search...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.fetchMatchingItems()
                        }
                        .padding([.horizontal, .bottom])
                }
                
                List(viewModel.items, id: \.self) { item in
                    ItemCellView(item: item) {
                        
                        // Stop any currently playing preview
                        if let player = viewModel.previewPlayer {
                            player.pause()
                            viewModel.previewPlayer = nil
                        }
                        
    
                        if let previewTask = viewModel.previewTask {
                            previewTask.cancel()
                        }
                        
                        guard let previewUrl = item.previewUrl else { return }

                        viewModel.previewTask = Task {
                            do {
                                // Download the preview data
                                let (data, _) = try await URLSession.shared.data(from: previewUrl)
                                
                                let tempDirectory = FileManager.default.temporaryDirectory
                                let tempFileUrl = tempDirectory.appendingPathComponent(previewUrl.lastPathComponent)
                                
                                try data.write(to: tempFileUrl, options: .atomic)
                                
                                // Create and start the player on the main actor
                                await MainActor.run {
                                    viewModel.previewPlayer = AVPlayer(url: tempFileUrl)
                                    viewModel.previewPlayer?.play()
                                }
                            } catch is CancellationError {
                        
                            } catch {
                                print("Failed to load or play preview: \(error)")
                            }
                            
                            await MainActor.run {
                                viewModel.previewTask = nil
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("iTunes Search")
            .onAppear {
                viewModel.fetchMatchingItems()
            }
            .onChange(of: viewModel.selectedMediaType) { _, _ in
                
                if !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    viewModel.fetchMatchingItems()
                }
            }
        }
    }
}

#Preview {
 StoreItemListView()
}
