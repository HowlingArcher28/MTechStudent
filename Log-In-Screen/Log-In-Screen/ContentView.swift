//
//  ContentView.swift
//  Log-In-Screen
//
//  Created by Zachary Jensen on 1/5/26.
//

import SwiftUI

struct ContentView: View {
    enum Field {
        case email
        case password
    }

    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.largeTitle).bold()
                        .accessibilityAddTraits(.isHeader)
                    Text("Please sign in to continue")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }

                VStack(spacing: 16) {
                    TextField("Email", text: $viewModel.email)
                        .textContentType(.username)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .inputFieldStyle()
                        .onChange(of: viewModel.email) { viewModel.markEditingIfNeeded() }
                        .onSubmit { focusedField = .password }

                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.password)
                        .submitLabel(.go)
                        .focused($focusedField, equals: .password)
                        .inputFieldStyle()
                        .onChange(of: viewModel.password) { viewModel.markEditingIfNeeded() }
                        .onSubmit { submit() }
                }

                if let message = viewModel.state.message {
                    StatusMessageView(message: message, color: viewModel.state.messageColor)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

                LoadingButton(
                    title: "Log In",
                    isLoading: viewModel.state.isLoading,
                    isDisabled: !viewModel.canSubmit || viewModel.state.isLoading,
                    action: submit
                )

                Divider().padding(.vertical, 8)

                Spacer(minLength: 0)
            }
            .padding()
        }
    }

    private func submit() {
        focusedField = nil
        viewModel.logIn()
    }
}

private struct StatusMessageView: View {
    let message: String
    let color: Color

    var body: some View {
        Text(message)
            .foregroundStyle(color)
            .font(.footnote)
            .multilineTextAlignment(.center)
    }
}

private extension View {
    func inputFieldStyle() -> some View {
        self
            .padding(12)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.separator, lineWidth: 1)
            )
    }
}

#Preview {
    ContentView()
}
