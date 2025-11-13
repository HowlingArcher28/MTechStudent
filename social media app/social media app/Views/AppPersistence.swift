// AppPersistence.swift
import Foundation

struct AppPersistence {
    struct AppState: Codable {
        var profile: UserProfile
        var currentUser: String
        var posts: [FunnyPost]
    }

    private var stateURL: URL {
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("AppState.json")
    }

    func save(_ state: AppState) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(state)
            try data.write(to: stateURL, options: .atomic)
        } catch {
            // In production you might log this
            // print("Failed to save state: \(error)")
        }
    }

    func load() -> AppState? {
        do {
            let data = try Data(contentsOf: stateURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(AppState.self, from: data)
        } catch {
            return nil
        }
    }

    func delete() {
        do {
            try FileManager.default.removeItem(at: stateURL)
        } catch {
            // print("Failed to delete state: \(error)")
        }
    }

    func lastSavedDate() -> Date? {
        do {
            let attrs = try FileManager.default.attributesOfItem(atPath: stateURL.path)
            return attrs[.modificationDate] as? Date
        } catch {
            return nil
        }
    }
}
