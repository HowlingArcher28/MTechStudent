import Foundation

// MARK: - FakeUserRepository
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

// MARK: - StubUserRepository
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

// MARK: - MockUserRepository
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

// MARK: - MockLogger
public final class MockLogger: LoggerProtocol {
    public private(set) var messages: [String] = []
    
    public init() {}
    
    public func log(_ message: String) {
        messages.append(message)
    }
}

