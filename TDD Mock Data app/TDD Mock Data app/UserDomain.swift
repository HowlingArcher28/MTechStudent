import Foundation

struct AppUser: Equatable, Codable {
    let id: Int
    let name: String
}

protocol UserRepositoryProtocol {
    func fetchUser(id: Int) async throws -> AppUser
}

protocol LoggerProtocol {
    func log(_ message: String)
}

enum UserServiceError: Error, Equatable {
    case notFound
    case network
    case unknown
}
