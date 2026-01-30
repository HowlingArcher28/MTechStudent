import Foundation

public final class MockUserRepository: UserRepositoryProtocol {
    private let results: [Int: Result<AppUser, UserServiceError>]
    public private(set) var fetchCalls: [Int] = []
    
    public init(resultsMap: [Int: Result<AppUser, UserServiceError>]) {
        self.results = resultsMap
    }
    
    public func fetchUser(id: Int) throws -> AppUser {
        fetchCalls.append(id)
        let result = results[id, default: Result<AppUser, UserServiceError>.failure(.notFound)]
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}
