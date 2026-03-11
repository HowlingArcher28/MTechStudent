/*
 LoginView.swift
 
 Overview:
 A basic login screen with email and password fields that calls AuthModel.signIn
 using async/await. Displays loading state and any error messages.
*/

import SwiftUI

struct LoginView: View {

    // Read the auth model so we can call sign in and show errors
    @Environment(AuthModel.self) var auth: AuthModel
    // Local text field state
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                
                // App Title
                Text("Calender App")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                // If the server sent an error (like bad password), show it here
                if let error = auth.errorMessage {
                    Text(error)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                }
                
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                
                // Sign In Button
                Button(action: {
                    Task { // Call sign in using async/await
                        await auth.signIn(email: email, password: password)
                    }
                }) {
                    if auth.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Sign In")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(auth.isLoading || email.isEmpty || password.isEmpty) // Don't let them tap while loading or with empty fields
                .opacity((email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

