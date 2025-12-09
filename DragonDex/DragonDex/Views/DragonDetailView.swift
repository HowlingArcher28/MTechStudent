// DragonDetailView.swift
import SwiftUI
import UIKit

struct DragonDetailView: View {
    @EnvironmentObject private var themeStore: ThemeStore
    let dragon: Dragon

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                titleAndMeta
                stats
                portraitBelowStats
                description
                powers
            }
            .padding()
        }
        .background(themeStore.background)
        .navigationTitle(dragon.name)
        .navigationBarTitleDisplayMode(.inline)
        .tint(themeStore.accentColor)
    }

    // Name, element, rarity at the top
    private var titleAndMeta: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dragon.name)
                .font(.title2).bold()
                .foregroundStyle(themeStore.primaryText)
            HStack(spacing: 8) {
                Label(dragon.element.displayName, systemImage: dragon.element.symbolName)
                    .foregroundStyle(dragon.element.color)
                RarityView(rarity: dragon.rarity)
            }
        }
    }

    private var stats: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Stats")
                .font(.headline)
                .foregroundStyle(themeStore.primaryText)
            HStack {
                StatChip(title: "HP", value: dragon.stats.hp)
                StatChip(title: "ATK", value: dragon.stats.attack)
                StatChip(title: "SPD", value: dragon.stats.speed)
            }
        }
    }

    private var portraitBelowStats: some View {
        dragonImage(named: dragon.imageName, for: dragon.element)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(dragon.element.color.opacity(0.25), lineWidth: 1)
            )
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline)
                .foregroundStyle(themeStore.primaryText)
            Text(dragon.description)
                .foregroundStyle(themeStore.secondaryText)
        }
    }

    private var powers: some View {
        let index = SampleData.powerIndex
        let powers = dragon.powerIDs.compactMap { index[$0] }

        return Group {
            if powers.isEmpty {
                EmptyView()
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Powers").font(.headline)
                        .foregroundStyle(themeStore.primaryText)
                    ForEach(powers) { power in
                        HStack {
                            Label(power.name, systemImage: power.element.symbolName)
                                .foregroundStyle(power.element.color)
                            Spacer()
                            Text("DMG \(power.damage)")
                                .font(.caption)
                                .foregroundStyle(themeStore.secondaryText)
                        }
                        .padding(8)
                        .background(themeStore.secondaryBackground, in: RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }

    // MARK: - Image helpers

    private func dragonImage(named name: String, for element: Element) -> Image {
        // 1) Try the explicit dragon asset first
        if let ui = UIImage(named: name) {
            return Image(uiImage: ui)
        }
        // 2) Fall back to an element-specific placeholder asset
        if let placeholder = placeholderName(for: element),
           let ui = UIImage(named: placeholder) {
            return Image(uiImage: ui)
        }
        // 3) Final fallback: element SF Symbol
        return Image(systemName: element.symbolName)
    }

    private func placeholderName(for element: Element) -> String? {
        switch element {
        case .earth: return "EarthDragon"
        case .fire: return "FireDragon"
        case .ice: return "IceDragon"
        case .nature: return "PlantDragon"
        case .water: return "WaterDragon"
        case .air: return "SpaceDragon"
        case .lightning: return "SpaceDragon"
        case .shadow: return "ToxicDragon"
        case .light: return "SpaceDragon"
        }
    }
}

private struct StatChip: View {
    @EnvironmentObject private var themeStore: ThemeStore
    let title: String
    let value: Int

    var body: some View {
        HStack {
            Text(title).font(.caption).bold()
            Text("\(value)").font(.caption)
        }
        .foregroundStyle(themeStore.primaryText)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(themeStore.secondaryBackground, in: Capsule())
    }
}

