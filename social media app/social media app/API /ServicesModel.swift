import SwiftUI
import Combine

@MainActor
class ServicesModel: ObservableObject {
    
    private let apiClient: APIClient
    private let auth: AuthModel
    
    @Published var posts: [PostDTO] = []
    @Published var userProfile: UserProfileDTO?
    @Published var errorMessage: String?
    
    init(apiClient: APIClient, auth: AuthModel) {
        self.apiClient = apiClient
        self.auth = auth
    }
    
    // MARK: Load Posts
    func loadPosts(page: Int = 0) async {
        guard let userSecret = auth.user?.secret else {
            errorMessage = "User not signed in"
            return
        }
        do {
            let fetchedPosts = try await apiClient.getPosts(userSecret: userSecret, pageNumber: page)
            self.posts = fetchedPosts
        } catch let error as APIErrorDTO {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Load User Profile
    func loadUserProfile() async {
        guard let user = auth.user else {
            errorMessage = "User not signed in"
            return
        }
        do {
            let profile = try await apiClient.getUserProfile(userUUID: user.userUUID, userSecret: user.secret)
            self.userProfile = profile
        } catch let error as APIErrorDTO {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Create Post
    func createPost(title: String, body: String) async {
        guard let userSecret = auth.user?.secret else {
            errorMessage = "User not signed in"
            return
        }
        do {
            let newPost = try await apiClient.createPost(userSecret: userSecret, title: title, body: body)
            posts.insert(newPost, at: 0) // newest posts at the top
        } catch let error as APIErrorDTO {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Reload everything (posts + profile)
    func reloadAll() async {
        await loadUserProfile()
        await loadPosts()
    }
}
