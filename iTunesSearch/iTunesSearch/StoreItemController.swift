//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Zachary Jensen on 11/14/25.
//

import Foundation

final class StoreItemController {
    private let api: APIService

    init(api: APIService = URLSessionAPIService()) {
        self.api = api
    }

    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        // Use the API service to perform the request and decode
        let searchResponse: SearchResponse = try await api.get(url, decode: SearchResponse.self)
        return searchResponse.results
    }
}
