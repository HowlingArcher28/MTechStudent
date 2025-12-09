// Element.swift
import SwiftUI

enum Element: String, CaseIterable, Codable, Identifiable {
    case fire, water, earth, air, lightning, ice, nature, shadow, light

    var id: String { rawValue }

    var displayName: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .fire: return .red
        case .water: return .blue
        case .earth: return .brown
        case .air: return .teal
        case .lightning: return .yellow
        case .ice: return .cyan
        case .nature: return .green
        case .shadow: return Color(hue: 0.67, saturation: 0.55, brightness: 0.95) // brighter indigo
        case .light: return .orange
        }
    }

    var symbolName: String {
        switch self {
        case .fire: return "flame.fill"
        case .water: return "drop.fill"
        case .earth: return "leaf.fill"
        case .air: return "wind"
        case .lightning: return "bolt.fill"
        case .ice: return "snowflake"
        case .nature: return "tree.fill"
        case .shadow: return "moon.fill"
        case .light: return "sun.max.fill"
        }
    }
}
