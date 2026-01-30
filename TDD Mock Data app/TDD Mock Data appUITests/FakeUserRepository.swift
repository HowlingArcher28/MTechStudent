import Foundation

public final class FakeUserRepository: UserRepositoryProtocol {
    private var users: [Int: AppUser]
    
    public init(users: [Int: AppUser]) {
        self.users = users
    }
    
    public func fetchUser(id: Int) throws -> AppUser {
        guard let user = users[id] else {
            throw UserServiceError.notFound
        }
        return user
    }
}

