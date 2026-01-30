import Foundation

public protocol UserService {
    func fetchUser(id: UUID) async throws -> User
    func allUsers() async throws -> [User]
}

public enum UserServiceError: Error { case notFound }
