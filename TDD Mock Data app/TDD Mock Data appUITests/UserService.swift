import Foundation

public final class UserService {
    private let repository: UserRepositoryProtocol
    private let logger: LoggerProtocol
    
    public init(repository: UserRepositoryProtocol, logger: LoggerProtocol) {
        self.repository = repository
        self.logger = logger
    }
    
    // Basic functionality: fetch a user and log outcome
    public func getUserName(for id: Int) -> Result<String, UserServiceError> {
        do {
            let user = try repository.fetchUser(id: id)
            logger.log("Fetched user: \(user.name)")
            return .success(user.name)
        } catch let error as UserServiceError {
            logger.log("Failed to fetch user with id: \(id) - error: \(error)")
            return .failure(error)
        } catch {
            logger.log("Unexpected error for id: \(id)")
            return .failure(.notFound)
        }
    }
}
