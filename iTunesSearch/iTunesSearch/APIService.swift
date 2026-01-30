import Foundation

// Defines the abstraction for networking so higher layers can be tested and decoupled
protocol APIService {
    func get<T: Decodable>(_ url: URL, decode type: T.Type) async throws -> T
}

// Concrete implementation using URLSession
struct URLSessionAPIService: APIService {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable>(_ url: URL, decode type: T.Type) async throws -> T {
        let (data, response) = try await session.data(from: url)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
