import SwiftUI
import Combine

@MainActor
class AuthModel: ObservableObject {
    private let apiClient: APIClient
    
    @Published var user: SignInResponseDTO?
    @Published var errorMessage: String?
    
    var isLoggedIn: Bool {
        user != nil
    }
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func signIn(email: String, password: String) async {
        do {
            let user = try await apiClient.signIn(email: email, password: password)
            self.user = user
        } catch let error as APIErrorDTO {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
