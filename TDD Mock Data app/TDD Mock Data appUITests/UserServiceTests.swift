import XCTest
@testable import TDD_Mock_Data_app

// Test doubles conforming to production protocols
struct FakeUserRepository: UserRepository {
    let users: [Int: AppUser]
    func fetchUser(id: Int) -> Result<AppUser, UserError> {
        if let user = users[id] { return .success(user) }
        return .failure(.notFound)
    }
}

struct StubUserRepository: UserRepository {
    let resultsMap: [Int: Result<AppUser, UserError>]
    func fetchUser(id: Int) -> Result<AppUser, UserError> {
        return resultsMap[id] ?? .failure(.notFound)
    }
}

final class MockUserRepository: UserRepository {
    let resultsMap: [Int: Result<AppUser, UserError>]
    private(set) var fetchCalls: [Int] = []
    init(resultsMap: [Int: Result<AppUser, UserError>]) { self.resultsMap = resultsMap }
    func fetchUser(id: Int) -> Result<AppUser, UserError> {
        fetchCalls.append(id)
        return resultsMap[id] ?? .failure(.notFound)
    }
}

final class MockLogger: Logger {
    private(set) var messages: [String] = []
    func log(_ message: String) { messages.append(message) }
}

final class UserServiceTests: XCTestCase {
    func test_getUserName_withFake_returnsName_whenUserExists() {
        // Arrange
        let fakeRepo = FakeUserRepository(users: [1: AppUser(id: 1, name: "Alice")])
        let logger = MockLogger()
        let sut = UserService(repository: fakeRepo, logger: logger)
        
        // Act
        let result = sut.getUserName(for: 1)
        
        // Assert
        switch result {
        case .success(let name):
            XCTAssertEqual(name, "Alice")
            XCTAssertTrue(logger.messages.contains(where: { $0.contains("Fetched user") }))
        case .failure:
            XCTFail("Expected success")
        }
    }
    
    func test_getUserName_withFake_returnsNotFound_whenUserMissing() {
        let fakeRepo = FakeUserRepository(users: [:])
        let logger = MockLogger()
        let sut = UserService(repository: fakeRepo, logger: logger)
        
        let result = sut.getUserName(for: 99)
        
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure(let error):
            XCTAssertEqual(error, UserError.notFound)
            XCTAssertTrue(logger.messages.contains(where: { $0.contains("Failed to fetch user") }))
        }
    }
    
    func test_getUserName_withStub_variesByInput() {
        // Arrange
        let stub = StubUserRepository(resultsMap:
            [Int: Result<AppUser, UserError>](uniqueKeysWithValues: [
                (1, .success(AppUser(id: 1, name: "Alice"))),
                (2, .success(AppUser(id: 2, name: "Bob"))),
                (3, .failure(UserError.notFound))
            ])
        )
        let logger = MockLogger()
        let sut = UserService(repository: stub, logger: logger)
        
        // Act & Assert
        XCTAssertEqual(try? sut.getUserName(for: 1).get(), "Alice")
        XCTAssertEqual(try? sut.getUserName(for: 2).get(), "Bob")
        if case .failure(let error) = sut.getUserName(for: 3) {
            XCTAssertEqual(error, UserError.notFound)
        } else {
            XCTFail("Expected notFound for id 3")
        }
    }
    
    func test_getUserName_withMock_recordsFetchCalls_andLogs() {
        // Arrange
        let mock = MockUserRepository(resultsMap:
            [Int: Result<AppUser, UserError>](uniqueKeysWithValues: [
                (1, .success(AppUser(id: 1, name: "Alice")))
            ])
        )
        let logger = MockLogger()
        let sut = UserService(repository: mock, logger: logger)
        
        // Act
        _ = sut.getUserName(for: 1)
        _ = sut.getUserName(for: 42)
        
        // Assert
        XCTAssertEqual(mock.fetchCalls, [1, 42])
        XCTAssertFalse(logger.messages.isEmpty)
    }
}

