// PowerListView.swift
import SwiftUI

struct PowerListView: View {
    @EnvironmentObject private var themeStore: ThemeStore
    @StateObject var viewModel: PowerListViewModel

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

            ForEach(viewModel.filteredPowers) { power in
                PowerRow(power: power)
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

private struct PowerRow: View {
    @EnvironmentObject private var themeStore: ThemeStore
    let power: Power

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(power.element.color.opacity(0.15))
                Image(systemName: power.element.symbolName)
                    .foregroundStyle(power.element.color)
            }
            .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(power.name)
                    .font(.headline)
                    .foregroundStyle(themeStore.primaryText)
                HStack(spacing: 8) {
                    Text(power.element.displayName)
                        .font(.caption)
                        .foregroundStyle(power.element.color)
                    Text("DMG \(power.damage)")
                        .font(.caption)
                        .foregroundStyle(themeStore.secondaryText)
                    Text("Cost \(power.cost)")
                        .font(.caption)
                        .foregroundStyle(themeStore.secondaryText)
                }
            }
            Spacer()
        }
    }
}
