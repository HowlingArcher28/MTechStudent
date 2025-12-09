// DragonListView.swift
import SwiftUI
import UIKit

struct DragonListView: View {
    @EnvironmentObject private var themeStore: ThemeStore
    @StateObject var viewModel: DragonListViewModel

    var body: some View {
        List {
            if let element = viewModel.selectedElement {
                Section {
                    HStack {
                        Image(systemName: element.symbolName)
                            .foregroundStyle(element.color)
                        Text("Filtered by \(element.displayName)")
                            .foregroundStyle(themeStore.primaryText)
                        Spacer()
                        Button("Clear") { viewModel.selectedElement = nil }
                            .buttonStyle(.borderless)
                    }
                }
                .listRowBackground(themeStore.listRowBackground)
            }

            ForEach(viewModel.filteredDragons) { dragon in
                NavigationLink {
                    DragonDetailView(dragon: dragon)
                } label: {
                    DragonRow(dragon: dragon)
                }
                .listRowBackground(themeStore.listRowBackground)
            }
        }
        .scrollContentBackground(.hidden)
        .background(themeStore.background)
        .searchable(text: $viewModel.searchText)
        .toolbar {
            Menu {
                Button("All Elements") { viewModel.selectedElement = nil }
                Divider()
                ForEach(Element.allCases) { element in
                    Button {
                        viewModel.selectedElement = element
                    } label: {
                        Label(element.displayName, systemImage: element.symbolName)
                            .labelStyle(.titleAndIcon)
                    }
                }
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
        .tint(themeStore.accentColor)
    }
}

private struct DragonRow: View {
    @EnvironmentObject private var themeStore: ThemeStore
    let dragon: Dragon

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(dragon.element.color.opacity(0.15))

                // Thumbnail image: try dragon asset, then element placeholder, else symbol
                thumbnailImage(for: dragon)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            }
            .frame(width: 44, height: 44)
            .overlay(
                Circle()
                    .stroke(dragon.element.color.opacity(0.2), lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(dragon.name)
                    .font(.headline)
                    .foregroundStyle(themeStore.primaryText)
                HStack(spacing: 8) {
                    Label(dragon.element.displayName, systemImage: dragon.element.symbolName)
                        .font(.caption)
                        .foregroundStyle(dragon.element.color)
                    RarityView(rarity: dragon.rarity)
                }
            }
            Spacer()
        }
    }

    // MARK: - Image helpers

    private func thumbnailImage(for dragon: Dragon) -> Image {
        if let ui = UIImage(named: dragon.imageName) {
            return Image(uiImage: ui)
        }
        if let placeholder = placeholderName(for: dragon.element),
           let ui = UIImage(named: placeholder) {
            return Image(uiImage: ui)
        }
        return Image(systemName: dragon.element.symbolName)
            .renderingMode(.template)
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

