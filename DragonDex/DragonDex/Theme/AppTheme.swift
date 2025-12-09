
import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark
    case fire
    case ice
    case nature
    case shadow
    case lightbringer

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        case .fire: return "Fire"
        case .ice: return "Ice"
        case .nature: return "Nature"
        case .shadow: return "Shadow"
        case .lightbringer: return "Lightbringer"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light, .fire, .ice, .nature, .lightbringer: return .light
        case .dark, .shadow: return .dark
        }
    }

    var accentColor: Color {
        switch self {
        case .system: return .accentColor
        case .light: return .blue
        case .dark: return Color(hue: 0.74, saturation: 0.55, brightness: 0.95)
        case .fire: return .red
        case .ice: return .cyan
        case .nature: return .green
        case .shadow: return Color(hue: 0.67, saturation: 0.55, brightness: 0.95)
        case .lightbringer: return .orange
        }
    }

    var background: Color {
        switch self {
        case .system:
            return Color(.systemBackground)
        case .light, .ice:
            return Color(.systemGroupedBackground)
        case .dark:
            return Color(red: 0.10, green: 0.12, blue: 0.16)
        case .shadow:
            return Color(red: 0.294, green: 0.0, blue: 0.51)
        case .fire:
            return Color(red: 0.99, green: 0.96, blue: 0.95)
        case .nature:
            return Color(red: 0.95, green: 0.98, blue: 0.95)
        case .lightbringer:
            return Color(red: 1.00, green: 0.98, blue: 0.94)
        }
    }

    var secondaryBackground: Color {
        switch self {
        case .system:
            return Color(.secondarySystemBackground)
        case .light, .ice:
            return Color.white
        case .dark:
            return Color(red: 0.17, green: 0.18, blue: 0.22)
        case .shadow:
            return Color(red: 0.12, green: 0.14, blue: 0.20)
        case .fire:
            return Color(red: 1.00, green: 0.93, blue: 0.90)
        case .nature:
            return Color(red: 0.90, green: 0.97, blue: 0.91)
        case .lightbringer:
            return Color(red: 1.00, green: 0.96, blue: 0.89)
        }
    }

    var listRowBackground: Color {
        switch self {
        case .system:
            return Color(.secondarySystemBackground)
        case .light, .ice:
            return Color.white
        case .dark:
            return Color(red: 0.22, green: 0.23, blue: 0.27)
        case .shadow:
            return Color(red: 0.20, green: 0.22, blue: 0.28)
        case .fire:
            return Color(red: 1.00, green: 0.92, blue: 0.88)
        case .nature:
            return Color(red: 0.88, green: 0.96, blue: 0.89)
        case .lightbringer:
            return Color(red: 1.00, green: 0.95, blue: 0.87)
        }
    }

    // MARK: Text colors
    var primaryText: Color {
        switch self {
        case .system, .light, .ice, .fire, .nature, .lightbringer:
            return Color.primary
        case .dark, .shadow:
            return Color.primary
        }
    }

    var secondaryText: Color {
        switch self {
        case .system, .light, .ice, .fire, .nature, .lightbringer:
            return Color.secondary
        case .dark, .shadow:
            return Color.white.opacity(0.85)
        }
    }
}
