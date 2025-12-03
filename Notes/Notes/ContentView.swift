//
//  ContentView.swift
//  Notes
//
//  Created by Zachary Jensen on 12/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Journal.createdAt, order: .reverse) private var journals: [Journal]
    @Environment(\.modelContext) private var modelContext

    @State private var showingAddJournal = false
    @State private var newJournalName = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(journals) { journal in
                    NavigationLink {
                        JournalDetailView(journal: journal)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(journal.name)
                                .font(.headline)
                            Text("\(journal.notes.count) entries")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(journal.createdAt, style: .date)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: deleteJournals)
            }
            .navigationTitle("Journals")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddJournal = true
                    } label: {
                        Label("Add Journal", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddJournal) {
                NavigationStack {
                    Form {
                        Section(header: Text("Journal Name")) {
                            TextField("Enter Journal name", text: $newJournalName)
                        }
                    }
                    .navigationTitle("New Journal")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingAddJournal = false
                                newJournalName = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                addJournal()
                                showingAddJournal = false
                            }
                            .disabled(newJournalName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Journal Actions

    private func addJournal() {
        let journal = Journal(name: newJournalName)
        modelContext.insert(journal)
        newJournalName = ""
    }

    private func deleteJournals(at offsets: IndexSet) {
        for index in offsets {
            let journal = journals[index]
            modelContext.delete(journal)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Journal.self, Note.self])
}
