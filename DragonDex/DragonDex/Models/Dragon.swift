// Dragon.swift
import Foundation

struct Dragon: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var element: Element
    var rarity: Int // 1–5
    var description: String
    var imageName: String
    var stats: DragonStats
    var powerIDs: [UUID]
    var isFavorite: Bool

    init(
        id: UUID = UUID(),
        name: String,
        element: Element,
        rarity: Int,
        description: String,
        imageName: String,
        stats: DragonStats,
        powerIDs: [UUID],
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.element = element
        self.rarity = rarity
        self.description = description
        self.imageName = imageName
        self.stats = stats
        self.powerIDs = powerIDs
        self.isFavorite = isFavorite
    }
}
