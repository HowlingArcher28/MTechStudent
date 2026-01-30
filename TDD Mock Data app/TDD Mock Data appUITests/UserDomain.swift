import Foundation

public struct AppUser: Equatable {
    public let id: Int
    public let name: String
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public enum UserServiceError: Error, Equatable {
    case notFound
}

public protocol UserRepositoryProtocol {
    func fetchUser(id: Int) throws -> AppUser
}

public protocol LoggerProtocol {
    func log(_ message: String)
}
