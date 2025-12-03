import SwiftUI
import SwiftData

struct JournalDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var journal: Journal

    @State private var showingAddNote = false
    @State private var newTitle = ""
    @State private var newBody = ""

    @State private var editingNote: Note? = nil
    @State private var editTitle = ""
    @State private var editBody = ""

    private var sortedNotes: [Note] {
        journal.notes.sorted { $0.createdAt > $1.createdAt }
    }

    var body: some View {
        List {
            ForEach(sortedNotes) { note in
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
        .navigationTitle(journal.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddNote = true
                } label: {
                    Label("Add Entry", systemImage: "plus")
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
                .navigationTitle("New Entry")
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
                .navigationTitle("Edit Entry")
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

    // MARK: - Note Actions

    private func addNote() {
        let note = Note(title: newTitle, body: newBody, journal: journal)
        // Insert inserts the note into a save file thing
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
