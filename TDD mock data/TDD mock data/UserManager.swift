import Foundation

public actor UserManager {
    private let service: UserService
    public init(service: UserService) { self.service = service }
    public func displayName(for id: UUID) async throws -> String { try await service.fetchUser(id: id).name }
    public func sortedUserNames() async throws -> [String] { try await service.allUsers().map(\.name).sorted() }
}
