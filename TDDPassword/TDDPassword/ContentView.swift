//
//  ContentView.swift
//  AdvancedTechniquesLab
//
//  Created by Ethan Allgaier on 1/5/26.
//

import SwiftUI

enum LoginState {
    case idle
    case loading
    case success(String)
    case failure(String)
}

struct ContentView: View {
    var body: some View {
        MainView()
    }
}
struct MainView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var state: LoginState = .idle

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter Username", text: $username)
                .modifier(CustomView())
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)

            SecureField("Enter Password", text: $password)
                .modifier(CustomView())

            content()
                .padding(.top, 8)

            Button("Login") {
                handleLogin()
            }
            .buttonStyle(CustomButton())
        }
        .padding()
    }

    private func handleLogin() {
        // add test for this
        if username.isEmpty {
            state = .failure("Please enter a username.")
            return
        }
        // add test for this
        if password.isEmpty {
            state = .failure("Please enter a password.")
            return
        }
        state = .loading
        // Simulate a network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            state = .success("Login successful! Welcome, \(username)")
        }
    }

    @ViewBuilder
    private func content() -> some View {
        switch state {
        case .idle:
            Text("Idle")
                .foregroundStyle(.secondary)
        case .loading:
            ProgressView("Loading...")
        case .failure(let message):
            Text(message)
                .foregroundStyle(.red)
        case .success(let message):
            Text(message)
                .foregroundStyle(.green)
        }
    }
}

struct CustomView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(configuration.isPressed ? Color.blue.opacity(0.6) : Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(12)
            .shadow(radius: 4)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}

