import Foundation

public final class StubUserRepository: UserRepositoryProtocol {
    private let handler: (Int) -> Result<AppUser, UserServiceError>
    
    public init(_ handler: @escaping (Int) -> Result<AppUser, UserServiceError>) {
        self.handler = handler
    }
    
    public convenience init(resultsMap: [Int: Result<AppUser, UserServiceError>]) {
        self.init { id in
            resultsMap[id, default: Result<AppUser, UserServiceError>.failure(.notFound)]
        }
    }
    
    public func fetchUser(id: Int) throws -> AppUser {
        let result = handler(id)
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}
