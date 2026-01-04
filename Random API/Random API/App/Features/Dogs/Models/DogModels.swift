// DogModels.swift
import Foundation

struct Dog: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    let imageURL: URL

    init(id: UUID = UUID(), name: String, imageURL: URL) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
