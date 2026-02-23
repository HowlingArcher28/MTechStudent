//
//  AppModel.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class AppModel {
    // Persistence
    private let persistence = AppPersistence()

    // Central user profile
    var profile: UserProfile = UserProfile(
        firstName: "The",
        lastName: "Engineer",
        username: "the_engineer",
        bio: "Shipping features, fixing incidents, and adding emojis to commit messages.",
        profileImageName: "ProfileAvatar",
        coverImageName: nil
    ) {
        didSet {
            currentUser = profile.username
            save()
        }
    }

    // Legacy field still referenced by post logic
    var currentUser: String = "the_engineer" {
        didSet {
            save()
        }
    }

    init() {
        // Load saved state if available
        if let state = persistence.load() {
            self.profile = state.profile
            self.currentUser = state.currentUser
        } else {
            // Ensure currentUser starts in sync
            self.currentUser = profile.username
        }
    }

    // MARK: - Persistence API for Settings
    var lastSavedDate: Date? { persistence.lastSavedDate() }

    func saveNow() {
        save()
    }

    func exportStateData() -> Data? {
        let state = AppPersistence.AppState(profile: profile, currentUser: currentUser)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            return try encoder.encode(state)
        } catch {
            return nil
        }
    }

    func importState(from data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let state = try decoder.decode(AppPersistence.AppState.self, from: data)
        // Assign decoded state
        self.profile = state.profile
        self.currentUser = state.currentUser
        // Persist immediately
        save()
    }

    func clearAllData() {
        persistence.delete()
        // Reset to a minimal clean state
        self.profile = UserProfile(
            firstName: "The",
            lastName: "Engineer",
            username: "the_engineer",
            bio: "Shipping features, fixing incidents, and adding emojis to commit messages.",
            profileImageName: "ProfileAvatar",
            coverImageName: nil
        )
        self.currentUser = profile.username
        save()
    }

    // MARK: - Internal Save
    private func save() {
        let state = AppPersistence.AppState(profile: profile, currentUser: currentUser)
        persistence.save(state)
    }
}
