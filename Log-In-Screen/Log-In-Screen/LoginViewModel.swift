//
//  LoginViewModel.swift
//  Log-In-Screen
//
//  Created by Zachary Jensen on 1/5/26.
//

import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var state: TextState = .idle

    private let minPasswordLength = 4
    private let simulatedDelay: UInt64 = 1_000_000_000 // 1 second

    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.isEmpty
    }

    func markEditingIfNeeded() {
        switch state {
        case .idle, .error:
            withAnimation { state = .editing }
        default:
            break
        }
    }

    func logIn() {
        guard canSubmit else {
            withAnimation { state = .error("Please enter your email and password.") }
            return
        }

        guard isValidEmail(email) else {
            withAnimation { state = .error("Please enter a valid email address.") }
            return
        }

        withAnimation { state = .loading } // .isLoading gives it the wheel animation

        Task {
            try? await Task.sleep(nanoseconds: simulatedDelay)
            if password.count >= minPasswordLength {
                withAnimation { state = .success }
            } else {
                withAnimation { state = .error("Incorrect email or password.") }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
}
