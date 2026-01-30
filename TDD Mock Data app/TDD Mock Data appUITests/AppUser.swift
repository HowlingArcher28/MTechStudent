// Production domain and service types for the app target
import Foundation

public struct AppUser: Equatable, Hashable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public enum UserError: Error, Equatable {
    case notFound
}

public protocol UserRepository {
    func fetchUser(id: Int) -> Result<AppUser, UserError>
}

public protocol Logger {
    func log(_ message: String)
}

public final class UserService {
    private let repository: UserRepository
    private let logger: Logger
    
    public init(repository: UserRepository, logger: Logger) {
        self.repository = repository
        self.logger = logger
    }
    
    public func getUserName(for id: Int) -> Result<String, UserError> {
        let result = repository.fetchUser(id: id)
        switch result {
        case .success(let user):
            logger.log("Fetched user id=\(id)")
            return .success(user.name)
        case .failure(let error):
            logger.log("Failed to fetch user id=\(id) error=\(error)")
            return .failure(error)
        }
    }
}

