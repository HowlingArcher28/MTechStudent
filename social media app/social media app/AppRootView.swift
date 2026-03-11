/*
 AppRootView.swift
 
 Overview:
 The root view that wires up core environment models (AuthModel, ServicesModel)
 and decides whether to show the authenticated tab interface or the login
 screen based on authentication state.
*/

import SwiftUI

struct AppRootView: View {

    // Holds the authentication state for the whole app
    @State private var auth: AuthModel

    // Shared services used across screens (uses auth's secret)
    @State private var services: ServicesModel

    init() {
        // Create the API client with the base URL to our server
        let api = APIClient(baseURL: URL(string: "https://social-media-app.ryanplitt.com")!)
        let authModel = AuthModel(apiClient: api) // Auth model will store the user + secret in memory
        auth = authModel
        services = ServicesModel(apiClient: api, auth: authModel) // Services can now make authorized calls using the secret
    }

    var body: some View {
        Group {
            // If we have a user, show the main app; otherwise, show login
            if auth.isLoggedIn {
                MainTabView()
                    .environment(auth) // Put auth into the environment (so child views can read it)
                    .environment(services) // Put services into the environment too
            } else {
                LoginView()
                    .environment(auth) // Put auth into the environment (so child views can read it)
            }
        }
    }
}

