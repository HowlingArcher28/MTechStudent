// DogViewModel.swift
import Foundation
import SwiftUI
import Combine

@MainActor
final class DogViewModel: ObservableObject {
    @Published var currentImageURL: URL?
    @Published var currentName: String = ""
    @Published var savedDogs: [Dog] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let api: DogAPIControllerProtocol

    init(api: DogAPIControllerProtocol) {
        self.api = api
        Task { await loadFirstImageIfNeeded() }
    }

    func loadFirstImageIfNeeded() async {
        guard currentImageURL == nil else { return }
        await fetchNewImage(replacingCurrent: false)
    }

    func commitCurrentDogAndFetchNew() async {
        if let url = currentImageURL {
            let trimmed = currentName.trimmingCharacters(in: .whitespacesAndNewlines)
            let name = trimmed.isEmpty ? "Unnamed Pup" : trimmed
            savedDogs.insert(Dog(name: name, imageURL: url), at: 0)
            currentName = ""
        }
        await fetchNewImage(replacingCurrent: true)
    }

    private func fetchNewImage(replacingCurrent: Bool) async {
        isLoading = true
        errorMessage = nil
        do {
            let url = try await api.fetchRandomDogImage()
            withAnimation {
                self.currentImageURL = url
            }
        } catch {
            self.errorMessage = "Failed to load dog image. Please try again."
        }
        isLoading = false
    }

    func updateName(for dogID: UUID, to newName: String) {
        if let idx = savedDogs.firstIndex(where: { $0.id == dogID }) {
            savedDogs[idx].name = newName
        }
    }
}
