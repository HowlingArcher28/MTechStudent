//
//  ItemCellView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

import SwiftUI

struct ItemCellView: View {
    let item: StoreItem
    
    var onPlayButtonPressed: (() -> Void)? = nil

    var body: some View {
        HStack {
            if let url = item.artworkUrl100 {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 75, height: 75)
                            .cornerRadius(8)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                    case .empty:
                        ProgressView()
                            .frame(width: 75, height: 75)
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading) {
                Text(item.trackName ?? "(no name)")
                    .font(.headline)
                Text(item.artistName ?? "(no artist)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if item.previewUrl != nil, let onPlayButtonPressed {
                Spacer()
                Button {
                    onPlayButtonPressed()
                } label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
