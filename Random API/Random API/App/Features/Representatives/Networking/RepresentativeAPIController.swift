// RepresentativeAPIController.swift
import Foundation

struct RepresentativesResponse: Decodable {
    let results: [Representative]?
}

struct Representative: Identifiable, Decodable, Equatable {
    var id: String { link } // unique enough for list identity
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}

protocol RepresentativeAPIControllerProtocol {
    func fetchRepresentatives(zip: String) async throws -> [Representative]
}

final class RepresentativeAPIController: RepresentativeAPIControllerProtocol {
    func fetchRepresentatives(zip: String) async throws -> [Representative] {
        var comps = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php")!
        comps.queryItems = [
            URLQueryItem(name: "zip", value: zip),
            URLQueryItem(name: "output", value: "json")
        ]
        guard let url = comps.url else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // The API sometimes returns text/html; decoding still works if the body is JSON.
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(RepresentativesResponse.self, from: data)
        return decoded.results ?? []
    }
}
