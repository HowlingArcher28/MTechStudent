import Foundation
import Observation

@MainActor
@Observable
final class AuthModel {
    private struct DefaultsKeys {
        static let userSecret = "auth.userSecret"
        static let userName = "auth.userName"
        static let firstName = "auth.firstName"
        static let lastName = "auth.lastName"
        static let email = "auth.email"
    }

    var isAuthenticated: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?

    var userSecret: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var email: String?

    private var services: ServicesModel

    init(services: ServicesModel) {
        self.services = services

        // Always require login on launch
        self.isAuthenticated = false
        self.isLoading = false
        self.errorMessage = nil
        self.userSecret = nil
        self.userName = nil
        self.firstName = nil
        self.lastName = nil
        self.email = nil
    }

    convenience init() {
        self.init(services: ServicesModel())
    }

    func login(email: String, password: String) async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }

        do {
            let dto = try await services.api.login(email: email, password: password)

            // Update state
            self.userSecret = dto.secret
            self.userName = dto.userName
            self.firstName = dto.firstName
            self.lastName = dto.lastName
            self.email = dto.email
            self.isAuthenticated = true

            services.api.setBearerToken(dto.secret)

            // Persist
            let defaults = UserDefaults.standard
            defaults.set(dto.secret, forKey: DefaultsKeys.userSecret)
            defaults.set(dto.userName, forKey: DefaultsKeys.userName)
            defaults.set(dto.firstName, forKey: DefaultsKeys.firstName)
            defaults.set(dto.lastName, forKey: DefaultsKeys.lastName)
            defaults.set(dto.email, forKey: DefaultsKeys.email)
        } catch {
            print("[AuthModel] Login failed: \(error)")
            self.errorMessage = (error as NSError).localizedDescription
        }
    }

    func testServer() async -> String? {
        do {
            let result: String = try await services.api.authTest()
            self.errorMessage = nil
            return result
        } catch {
            self.errorMessage = (error as NSError).localizedDescription
            return nil
        }
    }

    func logout() {
        // Clear state
        isAuthenticated = false
        userSecret = nil
        userName = nil
        firstName = nil
        lastName = nil
        email = nil

        services.api.setBearerToken(nil)

        // Clear persistence
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: DefaultsKeys.userSecret)
        defaults.removeObject(forKey: DefaultsKeys.userName)
        defaults.removeObject(forKey: DefaultsKeys.firstName)
        defaults.removeObject(forKey: DefaultsKeys.lastName)
        defaults.removeObject(forKey: DefaultsKeys.email)
    }

    /// Validates the token with the server before marking the user as authenticated.
    func restoreSession() async {
        // If its already authenticated, no work to do
        if isAuthenticated { return }
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil

        let defaults = UserDefaults.standard
        guard let secret = defaults.string(forKey: DefaultsKeys.userSecret) else {
            // Nothing to restore
            return
        }

        // Restore basic profile fields (optional)
        let restoredUserName = defaults.string(forKey: DefaultsKeys.userName)
        let restoredFirstName = defaults.string(forKey: DefaultsKeys.firstName)
        let restoredLastName = defaults.string(forKey: DefaultsKeys.lastName)
        let restoredEmail = defaults.string(forKey: DefaultsKeys.email)

        // Set local state
        self.userSecret = secret
        self.userName = restoredUserName
        self.firstName = restoredFirstName
        self.lastName = restoredLastName
        self.email = restoredEmail

        // Configure API client with bearer token and validate with server
        services.api.setBearerToken(secret)
        do {
            _ = try await services.api.authTest()
            // Token is valid; mark as authenticated
            self.isAuthenticated = true
            self.errorMessage = nil
        } catch {
            if let decodingError = error as? DecodingError {
                print("[AuthModel] restoreSession decoding error: \(decodingError)")
            } else {
                print("[AuthModel] restoreSession failed: \(error)")
            }
            // Token invalid or other failure; clear state and persistence
            self.errorMessage = (error as NSError).localizedDescription
            self.logout()
        }
    }
}

//let data = try Data(contentsOf: makeRequest); let object = try JSONSerialization.jsonObject(with: data); let minified = try JSONSerialization.data(withJSONObject: object, options: [])

