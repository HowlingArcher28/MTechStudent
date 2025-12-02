//
//  ContentView.swift
//  Notes
//
//  Created by Zachary Jensen on 12/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Note.createdAt, order: .reverse) var notes: [Note]
    @Environment(\.modelContext) private var modelContext

    @State private var showingAddNote = false
    @State private var newTitle = ""
    @State private var newBody = ""
    
    @State private var editingNote: Note? = nil
    @State private var editTitle = ""
    @State private var editBody = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.body)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(note.createdAt, style: .date)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical, 4)
                    .onTapGesture {
                        beginEditing(note)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            delete(note)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddNote = true
                    } label: {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                NavigationStack {
                    Form {
                        Section(header: Text("Title")) {
                            TextField("Enter title", text: $newTitle)
                        }
                        Section(header: Text("Body")) {
                            TextEditor(text: $newBody)
                                .frame(minHeight: 120)
                        }
                    }
                    .navigationTitle("New Note")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingAddNote = false
                                newTitle = ""
                                newBody = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                addNote()
                                showingAddNote = false
                            }
                            .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                }
            }
            .sheet(item: $editingNote) { _ in
                NavigationStack {
                    Form {
                        Section(header: Text("Title")) {
                            TextField("Edit title", text: $editTitle)
                        }
                        Section(header: Text("Body")) {
                            TextEditor(text: $editBody)
                                .frame(minHeight: 120)
                        }
                    }
                    .navigationTitle("Edit Note")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                editingNote = nil
                                editTitle = ""
                                editBody = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save Changes") {
                                saveEdits()
                            }
                            .disabled(editTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                }
            }
        }
    }

    private func addNote() {
        let note = Note(title: newTitle, body: newBody)
        modelContext.insert(note)
        newTitle = ""
        newBody = ""
    }
    
    private func beginEditing(_ note: Note) {
        editingNote = note
        editTitle = note.title
        editBody = note.body
    }
    
    private func saveEdits() {
        guard let note = editingNote else { return }
        note.title = editTitle
        note.body = editBody
        editingNote = nil
        editTitle = ""
        editBody = ""
    }
    
    private func delete(_ note: Note) {
        modelContext.delete(note)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self)
}
