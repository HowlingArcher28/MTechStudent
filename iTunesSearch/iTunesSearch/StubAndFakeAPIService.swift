import Foundation

enum TestError: Error, Equatable {
    case alwaysFail
}

// Stub service that returns predetermined data for any URL/type
struct StubAPIService: APIService {
    let responseData: Data
    let statusCode: Int

    init<T: Encodable>(encodable: T, statusCode: Int = 200) throws {
        self.responseData = try JSONEncoder().encode(encodable)
        self.statusCode = statusCode
    }

    func get<T: Decodable>(_ url: URL, decode type: T.Type) async throws -> T {
        // Optionally simulate an HTTP status code check
        guard (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
}

// Fake service that always throws
struct FakeAPIService: APIService {
    let error: Error

    init(error: Error = TestError.alwaysFail) {
        self.error = error
    }

    func get<T>(_ url: URL, decode type: T.Type) async throws -> T where T : Decodable {
        throw error
    }
}
