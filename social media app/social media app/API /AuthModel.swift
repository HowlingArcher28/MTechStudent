/*
 AuthModel.swift
 
 Overview:
 Observable authentication model responsible for signing users in via APIClient
 and exposing their session information to SwiftUI views. Tracks loading state
 and surfaces user-readable error messages.
*/

import SwiftUI
import Combine

@MainActor @Observable // Runs on main thread and updates views when values change
class AuthModel {
    // We use this to talk to the server
    private let apiClient: APIClient
    
    // The logged-in user's info wich also includes the secret from the server
    var user: SignInResponseDTO?
    // If something goes wrong during sign in, we store a human-readable message
    var errorMessage: String?
    // True while we're waiting for the server to respond
    var isLoading: Bool = false
    
    // Simple helper so views can check if we have a user
    var isLoggedIn: Bool {
        user != nil
    }
    
    // Inject the API client when creating the model
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func signIn(email: String, password: String) async {
        // Start loading spinner
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await apiClient.signIn(email: email, password: password) // Ask the API to log in and decode the user (with secret)
            self.user = user // Keep the user in memory (secret is part of this object)
        } catch let error as APIErrorDTO { // Server gave us a friendly error message
            errorMessage = error.message
            print("API Error: \(error.message)")
        } catch { // Other errors (like network issues)
            errorMessage = error.localizedDescription
            print("Error: \(error.localizedDescription)")
        }
        
        // Stop loading spinner
        isLoading = false
    }
}

