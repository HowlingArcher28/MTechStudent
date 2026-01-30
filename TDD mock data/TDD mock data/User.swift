import Foundation

public struct User: Equatable, Identifiable {
    public let id: UUID
    public let name: String
    public init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
