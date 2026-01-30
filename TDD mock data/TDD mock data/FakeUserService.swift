import Foundation

public final class FakeUserService: UserService {
    private var storage: [UUID: User]
    public init(seed: [User] = []) {
        self.storage = Dictionary(uniqueKeysWithValues: seed.map { ($0.id, $0) })
    }
    public func fetchUser(id: UUID) async throws -> User {
        guard let u = storage[id] else { throw UserServiceError.notFound }
        return u
    }
    public func allUsers() async throws -> [User] { Array(storage.values) }
}
