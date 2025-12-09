// PowerListViewModel.swift
import Foundation
import SwiftUI
import Combine

@MainActor
final class PowerListViewModel: ObservableObject {
    @Published private(set) var allPowers: [Power] = []
    @Published var searchText: String = ""
    @Published var selectedElement: Element? = nil

    var filteredPowers: [Power] {
        allPowers.filter { power in
            (selectedElement == nil || power.element == selectedElement) &&
            (searchText.isEmpty || power.name.localizedCaseInsensitiveContains(searchText))
        }
    }

    init() {
        load()
    }

    func load() {
        allPowers = SampleData.powers
    }
}
