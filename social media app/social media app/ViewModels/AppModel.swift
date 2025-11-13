//
//  AppModel.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import Foundation
import Combine

@MainActor
final class AppModel: ObservableObject {
    // Persistence
    private let persistence = AppPersistence()
    private var cancellables: Set<AnyCancellable> = []

    // Central user profile
    @Published var profile: UserProfile = UserProfile(
        firstName: "The",
        lastName: "Engineer",
        username: "the_engineer",
        bio: "Shipping features, fixing incidents, and adding emojis to commit messages.",
        profileImageName: "ProfileAvatar",
        coverImageName: nil
    ) {
        didSet {
            currentUser = profile.username
        }
    }

    // Legacy field still referenced by post logic
    @Published var currentUser: String = "the_engineer"

    @Published var posts: [FunnyPost] = [
        FunnyPost(
            author: "BackendBen",
            text: "p95 down 37% after deleting 120 lines I was scared to touch. Performance by subtraction. ✂️⚡️ Added tracing to verify the hot path, removed redundant JSON encoding, and replaced a blocking call with async/await. Dashboards look happier; so do I."
        ),
        FunnyPost(
            author: "SRESara",
            text: "Incident resolved. Root cause: a config flag named ‘maybe’. New policy: names must commit. ✅ We added guardrails in CI, improved runbooks, and scheduled a follow-up review to ensure the mitigation sticks. Bonus: learned three new Grafana keyboard shortcuts."
        ),
        FunnyPost(
            author: "MobileMaya",
            text: "App startup -150ms: deferred non-critical work, memoized style computations, and removed a sneaky image decode on main. 🚀 Added a metric to watch regressions and a doc for future me. Users noticed—in a good way."
        )
    ]

    init() {
        // Load saved state if available
        if let state = persistence.load() {
            self.profile = state.profile
            self.currentUser = state.currentUser
            self.posts = state.posts
        } else {
            // Ensure currentUser starts in sync
            self.currentUser = profile.username
        }

        // Auto-save changes
        $profile
            .dropFirst()
            .sink { [weak self] _ in self?.save() }
            .store(in: &cancellables)

        $posts
            .dropFirst()
            .sink { [weak self] _ in self?.save() }
            .store(in: &cancellables)

        $currentUser
            .dropFirst()
            .sink { [weak self] _ in self?.save() }
            .store(in: &cancellables)
    }

    // MARK: - Post/Comment/Reaction
    func addPost(text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let post = FunnyPost(author: currentUser, text: text)
        posts.insert(post, at: 0)
    }

    func addComment(_ text: String, to post: FunnyPost) {
        guard let idx = posts.firstIndex(where: { $0.id == post.id }) else { return }
        let comment = Comment(author: currentUser, text: text)
        posts[idx].comments.append(comment)
    }

    func react(_ reaction: Reaction, to post: FunnyPost) {
        guard let idx = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[idx].reactions[reaction, default: 0] += 1
    }

    func deleteComment(_ comment: Comment, from post: FunnyPost) {
        guard let postIndex = posts.firstIndex(where: { $0.id == post.id }) else { return }
        guard comment.author == currentUser else { return }
        posts[postIndex].comments.removeAll { $0.id == comment.id }
    }

    // MARK: - Persistence API for Settings
    var lastSavedDate: Date? { persistence.lastSavedDate() }

    func saveNow() {
        save()
    }

    func exportStateData() -> Data? {
        let state = AppPersistence.AppState(profile: profile, currentUser: currentUser, posts: posts)
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
        self.posts = state.posts
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
        self.posts = []
        save()
    }

    func seedDemoData(using generator: PostGenerating? = nil) {
        let generator = generator ?? PostSeeder()
        var seeded = generator.generatePosts(count: 20)
        seeded.sort { $0.timestamp > $1.timestamp }
        self.posts = seeded
        save()
    }

    // MARK: - Internal Save
    private func save() {
        let state = AppPersistence.AppState(profile: profile, currentUser: currentUser, posts: posts)
        persistence.save(state)
    }
}
