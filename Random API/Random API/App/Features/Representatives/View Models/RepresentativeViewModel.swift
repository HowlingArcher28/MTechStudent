// RepresentativeViewModel.swift
import Foundation
import SwiftUI
import Combine

@MainActor
final class RepresentativeViewModel: ObservableObject {
    @Published var zip: String = ""
    @Published var representatives: [Representative] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let api: RepresentativeAPIControllerProtocol

    init(api: RepresentativeAPIControllerProtocol) {
        self.api = api
    }

    func search() async {
        let trimmed = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            representatives = []
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let reps = try await api.fetchRepresentatives(zip: trimmed)
            withAnimation {
                self.representatives = reps
            }
        } catch {
            self.errorMessage = "Failed to load representatives. Check the ZIP and try again."
            self.representatives = []
        }
        isLoading = false
    }
}
