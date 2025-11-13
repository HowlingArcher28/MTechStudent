import SwiftUI

enum EventEditorResult {
    case save(Event)
    case delete(Event)
    case cancel
}

struct EventEditorView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var id: UUID?
    @State private var title: String = ""
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var notes: String = ""
    @State private var color: Color = .blue

    let onComplete: (EventEditorResult) -> Void

    init(initialDate: Date, eventToEdit: Event? = nil, onComplete: @escaping (EventEditorResult) -> Void) {
        _startDate = State(initialValue: initialDate)
        _endDate = State(initialValue: initialDate.addingTimeInterval(60 * 60))
        if let ev = eventToEdit {
            _id = State(initialValue: ev.id)
            _title = State(initialValue: ev.title)
            _startDate = State(initialValue: ev.startDate)
            _endDate = State(initialValue: ev.endDate)
            _notes = State(initialValue: ev.notes ?? "")
            _color = State(initialValue: ev.color)
        }
        self.onComplete = onComplete
    }

    var body: some View {
        Form {
            Section("Details") {
                TextField("Title", text: $title)
                ColorPicker("Color", selection: $color, supportsOpacity: false)
                DatePicker("Start", selection: $startDate)
                DatePicker("End", selection: $endDate)
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
            }
        }
        .navigationTitle(id == nil ? "New Event" : "Edit Event")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    onComplete(.cancel)
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let ev = Event(
                        id: id ?? UUID(),
                        title: title.isEmpty ? "Untitled" : title,
                        startDate: startDate,
                        endDate: max(endDate, startDate),
                        notes: notes.isEmpty ? nil : notes,
                        color: color
                    )
                    onComplete(.save(ev))
                    dismiss()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            if let id = id {
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive) {
                        let ev = Event(
                            id: id,
                            title: title,
                            startDate: startDate,
                            endDate: endDate,
                            notes: notes.isEmpty ? nil : notes,
                            color: color
                        )
                        onComplete(.delete(ev))
                        dismiss()
                    } label: {
                        Label("Delete Event", systemImage: "trash")
                    }
                }
            }
        }
    }
}
