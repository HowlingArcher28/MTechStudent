//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/13/25.
//

import SwiftUI

enum MediaType: String, CaseIterable {
    case music
    case movies
    case apps
    case books

    var apiValue: String {
        switch self {
        case .music: return "music"
        case .movies: return "movie"
        case .apps: return "software"
        case .books: return "ebook"
        }
    }
}
