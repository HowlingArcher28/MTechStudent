//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Zachary Jensen on 11/14/25.
//

import Foundation

final class StoreItemController {
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        return searchResponse.results
    }
}
