// DogListCell.swift
import SwiftUI

struct DogListCell: View {
    let dog: Dog

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: dog.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "pawprint.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading) {
                Text(dog.name)
                    .font(.headline)
                Text(dog.imageURL.lastPathComponent)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}
