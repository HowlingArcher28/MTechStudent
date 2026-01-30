import Foundation
import Testing

@testable import iTunesSearch

@Suite("StoreItemController APIService doubles")
struct StoreItemControllerTests {

    @Test("Stub returns predetermined items")
    @MainActor
    func stubReturnsItems() async throws {
        // Arrange: make a canned response
        let items = [
            StoreItem(trackName: "Song A", artistName: "Artist 1", trackViewUrl: URL(string: "https://example.com/a"), previewUrl: URL(string: "https://example.com/a.m4a"), artworkUrl100: URL(string: "https://example.com/a.jpg")),
            StoreItem(trackName: "Song B", artistName: "Artist 2", trackViewUrl: URL(string: "https://example.com/b"), previewUrl: URL(string: "https://example.com/b.m4a"), artworkUrl100: URL(string: "https://example.com/b.jpg"))
        ]
        let canned = SearchResponse(resultCount: items.count, results: items)
        let stub = try StubAPIService(encodable: canned)
        let controller = StoreItemController(api: stub)

        // Act
        let results = try await controller.fetchItems(matching: ["term": "anything", "media": "music"]) 

        // Assert
        #expect(results == items)
        #expect(results.count == 2)
        #expect(results.first?.trackName == "Song A")
    }

    @Test("Fake always throws an error")
    @MainActor
    func fakeAlwaysThrows() async {
        // Arrange
        let fake = FakeAPIService()
        let controller = StoreItemController(api: fake)

        // Act & Assert
        do {
            _ = try await controller.fetchItems(matching: ["term": "anything", "media": "music"]) 
            Issue.record("Expected an error to be thrown, but none was thrown")
        } catch {
            // We expect TestError.alwaysFail by default
            if let testError = error as? TestError {
                #expect(testError == .alwaysFail)
            } else {
                Issue.record("Unexpected error type: \(error)")
            }
        }
    }
}

