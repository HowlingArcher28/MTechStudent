//
//  TextState.swift
//  Log-In-Screen
//
//  Created by Zachary Jensen on 1/5/26.
//
import SwiftUI

enum TextState: Equatable {
    case idle
    case editing
    case loading
    case success
    case error(String)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var message: String? {
        switch self {
        case .error(let message): return message
        case .success: return "You are logged in!"
        default: return nil
        }
    }

    var messageColor: Color {
        switch self {
        case .error: return .red
        case .success: return .green
        default: return .secondary
        }
    }
}
