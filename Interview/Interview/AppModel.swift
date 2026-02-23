//
//  AppModel.swift
//  Interview
//
//  Created by Zachary Jensen on 2/23/26.
//

import SwiftUI
import Observation

@Observable
class AppModel {
    var people: [Person] = []
    var selectionCount: Int = 1
    var selected: Set<UUID> = []

    private let saveURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("UserList.json")
    }()

    init() {
        load()
    }

    func addPerson(name: String) {
        people.append(Person(name: name))
        save()
    }

    func delete(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }

    func move(from: IndexSet, to: Int) {
        people.move(fromOffsets: from, toOffset: to)
        save()
    }

    func performSelection() {
        guard selectionCount <= people.count else { return }
        selected.removeAll()

        let shuffled = people.shuffled().prefix(selectionCount)
        selected = Set(shuffled.map { $0.id })
    }

    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let state = SavedState(people: people, selectionCount: selectionCount)
        if let data = try? encoder.encode(state) {
            try? data.write(to: saveURL, options: .atomic)
        }
    }

    func load() {
        guard let data = try? Data(contentsOf: saveURL) else { return }
        let decoder = JSONDecoder()
        if let state = try? decoder.decode(SavedState.self, from: data) {
            self.people = state.people
            self.selectionCount = state.selectionCount
        }
    }

    private struct SavedState: Codable {
        var people: [Person]
        var selectionCount: Int
    }
}
