// DogDetailView.swift
import SwiftUI

struct DogDetailView: View {
    @Binding var dog: Dog

    var body: some View {
        Form {
            Section("Preview") {
                AsyncImage(url: dog.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            ProgressView()
                        }
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Image(systemName: "pawprint.slash")
                            .font(.system(size: 48))
                            .frame(maxWidth: .infinity, minHeight: 180)
                            .foregroundStyle(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            Section("Name") {
                TextField("Dog name", text: $dog.name)
            }
        }
        .navigationTitle("Edit Dog")
    }
}
