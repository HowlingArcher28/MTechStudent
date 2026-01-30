import Foundation

final class DefaultUserService {
    private let repository: UserRepositoryProtocol
    private let logger: LoggerProtocol

    init(repository: UserRepositoryProtocol, logger: LoggerProtocol) {
        self.repository = repository
        self.logger = logger
    }
    
    convenience init() {
        self.init(repository: FakeUserRepository(), logger: ConsoleLogger())
    }

    func getUserName(id: Int) async -> Result<String, UserServiceError> {
        do {
            let user = try await repository.fetchUser(id: id)
            logger.log("Fetched user: \(user.name)")
            return .success(user.name)
        } catch {
            let userError: UserServiceError
            if let ue = error as? UserServiceError {
                userError = ue
            } else {
                userError = .unknown
            }
            logger.log("Error fetching user: \(userError)")
            return .failure(userError)
        }
    }
}

struct ConsoleLogger: LoggerProtocol {
    func log(_ message: String) {
        print(message)
    }
}

struct FakeUserRepository: UserRepositoryProtocol {
    func fetchUser(id: Int) async throws -> AppUser {
            try await Task.sleep(for: .milliseconds(300))
        return AppUser(id: id, name: "Test User \(id)")
    }
}

