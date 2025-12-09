// Power.swift
import Foundation

struct Power: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var element: Element
    var damage: Int
    var cost: Int
    var description: String

    init(id: UUID = UUID(), name: String, element: Element, damage: Int, cost: Int, description: String) {
        self.id = id
        self.name = name
        self.element = element
        self.damage = damage
        self.cost = cost
        self.description = description
    }
}
