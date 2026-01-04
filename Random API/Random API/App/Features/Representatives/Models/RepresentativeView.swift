// RepresentativeView.swift
import SwiftUI

struct RepresentativeView: View {
    @StateObject var viewModel: RepresentativeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    TextField("Enter ZIP code", text: $viewModel.zip)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .submitLabel(.search)
                        .onSubmit {
                            Task { await viewModel.search() }
                        }
                    Button {
                        Task { await viewModel.search() }
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                    .disabled(viewModel.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView("Searching…")
                        .padding()
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }

                List(viewModel.representatives) { rep in
                    RepresentativeCell(rep: rep)
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Representatives")
        }
    }
}
