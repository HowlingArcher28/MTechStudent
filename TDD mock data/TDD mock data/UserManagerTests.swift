import Testing
@testable import TDD_mock_data

@Suite("UserManager basic behavior")
struct UserManagerBasicTests {
    @Test("sortedUserNames returns sorted")
    func sortedUserNames_returnsSorted() async throws {
        let users = [User(name: "Zara"), User(name: "Ava"), User(name: "Milo")]
        let stub = StubUserService(users: users)
        let manager = UserManager(service: stub)
        let names = try await manager.sortedUserNames()
        #expect(names == ["Ava", "Milo", "Zara"])
    }

    @Test("displayName returns correct name")
    func displayName_returnsCorrectName() async throws {
        let target = User(name: "Ava")
        let stub = StubUserService(users: [target])
        let manager = UserManager(service: stub)
        let name = try await manager.displayName(for: target.id)
        #expect(name == "Ava")
    }

    @Test("displayName throws when not found")
    func displayName_throwsWhenNotFound() async {
        let stub = StubUserService(users: [])
        let manager = UserManager(service: stub)
        do {
            _ = try await manager.displayName(for: UUID())
            Issue.record("Expected notFound error")
        } catch let error as UserServiceError {
            #expect(error == .notFound)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}

@Suite("UserManager interactions with service")
struct UserManagerInteractionTests {
    @Test("sortedUserNames calls allUsers once")
    func sortedUserNames_callsAllUsersOnce() async throws {
        let mock = MockUserService()
        mock.allUsersResult = .success([User(name: "B"), User(name: "A")])
        let manager = UserManager(service: mock)
        _ = try await manager.sortedUserNames()
        #expect(mock.allUsersCallCount == 1)
        #expect(mock.fetchUserCalls.isEmpty)
    }

    @Test("displayName calls fetchUser with correct ID")
    func displayName_callsFetchUserWithCorrectID() async throws {
        let id = UUID()
        let mock = MockUserService()
        mock.fetchUserResult = .success(User(id: id, name: "X"))
        let manager = UserManager(service: mock)
        _ = try await manager.displayName(for: id)
        #expect(mock.fetchUserCalls == [id])
        #expect(mock.allUsersCallCount == 0)
    }
}

