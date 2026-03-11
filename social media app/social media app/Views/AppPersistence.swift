/*
 AppPersistence.swift
 
 Overview:
 A small helper that saves and loads light app state (profile
 and current user) to/from the app's documents directory as JSON. Provides a
 simple API for save, load, delete, and last-saved metadata.
*/

import Foundation

// Saves a tiny bit of app state to a JSON file on the device
struct AppPersistence {
    // The stuff we choose to save (profile + currentUser)
    struct AppState: Codable {
        var profile: UserProfile
        var currentUser: String
    }

    // Where the JSON file lives on disk (Documents/AppState.json)
    private var stateURL: URL {
        let fm = FileManager.default
        let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("AppState.json")
    }

    func save(_ state: AppState) {
        do {
            // Turn the AppState into JSON data
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(state)
            try data.write(to: stateURL, options: .atomic) // Write to disk safely
        } catch {
            // In production you might log this
            // print("Failed to save state: \(error)")
        }
    }

    func load() -> AppState? {
        do {
            // Read the JSON file
            let data = try Data(contentsOf: stateURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(AppState.self, from: data) // Convert JSON back into our Swift type
        } catch {
            return nil
        }
    }

    func delete() {
        do {
            try FileManager.default.removeItem(at: stateURL) // Delete the saved file if it exists
        } catch {
//            print("Failed to delete state: \(error)")
        }
    }

    func lastSavedDate() -> Date? {
        // Ask the file system for the file's last modified date
        do {
            let attrs = try FileManager.default.attributesOfItem(atPath: stateURL.path)
            return attrs[.modificationDate] as? Date
        } catch {
            return nil
        }
    }
}
