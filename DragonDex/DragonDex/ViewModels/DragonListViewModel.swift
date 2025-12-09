// DragonListViewModel.swift
import Foundation
import SwiftUI
import Combine

@MainActor
final class DragonListViewModel: ObservableObject {
    @Published private(set) var allDragons: [Dragon] = []
    @Published var searchText: String = ""
    @Published var selectedElement: Element? = nil

    var filteredDragons: [Dragon] {
        allDragons.filter { dragon in
            (selectedElement == nil || dragon.element == selectedElement) &&
            (searchText.isEmpty || dragon.name.localizedCaseInsensitiveContains(searchText))
        }
    }

    init() {
        load()
    }

    func load() {
        allDragons = SampleData.dragons
    }
}
