//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Zachary Jensen on 11/14/25.
//

import Foundation


struct SearchResponse: Codable {
    let resultCount: Int
    let results: [StoreItem]
}


struct StoreItem: Codable, Hashable {
    let trackName: String?
    let artistName: String?
    let trackViewUrl: URL?
    let previewUrl: URL?
    let artworkUrl100: URL?
}

