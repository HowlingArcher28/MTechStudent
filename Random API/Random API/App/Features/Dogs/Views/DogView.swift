// DogView.swift
import SwiftUI

struct DogView: View {
    @StateObject var viewModel: DogViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [.teal.opacity(0.2), .blue.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 260)

                    if let url = viewModel.currentImageURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 240)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .shadow(radius: 4)
                            case .failure:
                                VStack {
                                    Image(systemName: "pawprint.slash")
                                        .font(.system(size: 48))
                                    Text("Couldn’t load image")
                                        .foregroundStyle(.secondary)
                                }
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding()
                    } else if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Tap New Image to begin")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)

                HStack {
                    TextField("Give this dog a name", text: $viewModel.currentName)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                    Button {
                        Task { await viewModel.commitCurrentDogAndFetchNew() }
                    } label: {
                        Label("New Image", systemImage: "arrow.triangle.2.circlepath")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                    .disabled(viewModel.isLoading)
                }
                .padding(.horizontal)

                List {
                    if viewModel.savedDogs.isEmpty {
                        Text("Your named dogs will appear here.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(Array(viewModel.savedDogs.enumerated()), id: \.element.id) { index, dog in
                            NavigationLink {
                                // Bind directly to the dog inside the array
                                DogDetailView(dog: $viewModel.savedDogs[index])
                            } label: {
                                DogListCell(dog: dog)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Dogs")
        }
    }
}
