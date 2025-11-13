import UIKit
import Foundation

// MARK: - Build the iTunes Search URL using URLComponents
var components = URLComponents()
components.scheme = "https"
components.host = "itunes.apple.com"
components.path = "/search"

// MARK: - Adjust the query to whatever you want to search for.
components.queryItems = [
    URLQueryItem(name: "term", value: "Miles Smith"),
    URLQueryItem(name: "media", value: "music"),
    URLQueryItem(name: "limit", value: "5")
]

guard let url = components.url else {
    fatalError("Failed to build URL from components.")
}

// MARK: - Models for decoding the iTunes Search API response
struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let trackName: String?
    let artistName: String?
    let trackViewUrl: URL?
    let previewUrl: URL?
    let artworkUrl100: URL?
}

Task {
    do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            print("Did not receive an HTTP response.")
            return
        }
        guard httpResponse.statusCode == 200 else {
            print("Request failed with status code: \(httpResponse.statusCode)")
            if let body = String(data: data, encoding: .utf8) {
                print("Response body:\n\(body)")
            }
            return
        }

        // MARK: - Decode JSON
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)

        print("Found \(searchResponse.resultCount) results.")
        for (index, track) in searchResponse.results.enumerated() {
            let name = track.trackName ?? "(no track name)"
            let artist = track.artistName ?? "(no artist)"
            print("\(index + 1). \(name) — \(artist)")
        }

    } catch {
        print("Request failed with error: \(error)")
    }
}
