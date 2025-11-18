//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Zachary Jensen on 11/14/25.
//

import Foundation


struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [StoreItem]
}


struct StoreItem: Decodable, Hashable {
    let trackName: String?
    let artistName: String?
    let trackViewUrl: URL?
    let previewUrl: URL?
    let artworkUrl100: URL?
}
