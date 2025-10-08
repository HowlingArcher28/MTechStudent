//
//  ContentView.swift
//  List of something Lab
//
//  Created by Zachary Jensen on 10/7/25.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var store: QuoteStore
    @State private var isPresentingAdd = false
    @State private var selection = Set<Quote.ID>()

    var body: some View {
        NavigationStack {
            List(selection: $selection) {
                ForEach(store.quotes) { quote in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\"\(quote.text)\"")
                            .font(.headline)
                        HStack {
                            //MARK: - If author is left empty make author Unknown
                            Text(quote.author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Unknown" : quote.author)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(quote.dateAdded, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: store.delete)
            }
            .navigationTitle("My Favorite Quotes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresentingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .help("Add Quote")
                    .accessibilityLabel("Add Quote")
                }
                ToolbarItem(placement: .automatic) {
                    Button {
                        deleteSelection()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .help("Delete Selected")
                    .disabled(selection.isEmpty)
                }
            }
            .sheet(isPresented: $isPresentingAdd) {
                AddQuoteView(isPresented: $isPresentingAdd)
                    .environmentObject(store)
            }
        }
    }
        //MARK: - Allows the selected item to be deleted
    private func deleteSelection() {
        guard !selection.isEmpty else { return }
        let idsToDelete = selection
        selection.removeAll()
        let offsets = IndexSet(store.quotes.enumerated()
            .filter { idsToDelete.contains($0.element.id) }
            .map { $0.offset })
        store.delete(at: offsets)
    }
}

#Preview {
    FirstView()
        .environmentObject(QuoteStore())
}
