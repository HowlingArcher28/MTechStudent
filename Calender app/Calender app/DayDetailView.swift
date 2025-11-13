import SwiftUI

struct DayDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventStore: LocalEventStore

    let date: Date
    @State private var showingAdd = false
    @State private var editingEvent: Event?

    var body: some View {
        List {
            Section(header: Text(formattedDate(date))) {
                let events = eventStore.events(on: date)
                if events.isEmpty {
                    Text("No events").foregroundStyle(.secondary)
                } else {
                    ForEach(events) { event in
                        Button {
                            editingEvent = event
                            showingAdd = true
                        } label: {
                            HStack {
                                Circle().fill(event.color).frame(width: 8, height: 8)
                                VStack(alignment: .leading) {
                                    Text(event.title).font(.body)
                                    Text(timeRangeText(event))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                eventStore.delete(event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Day")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") { dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    editingEvent = nil
                    showingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAdd) {
            NavigationStack {
                EventEditorView(
                    initialDate: date,
                    eventToEdit: editingEvent
                ) { result in
                    switch result {
                    case .save(let event):
                        if let _ = editingEvent {
                            eventStore.update(event)
                        } else {
                            eventStore.add(event)
                        }
                    case .delete(let event):
                        eventStore.delete(event)
                    case .cancel:
                        break
                    }
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let fmt = DateFormatter()
        fmt.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        return fmt.string(from: date)
    }

    private func timeRangeText(_ event: Event) -> String {
        let fmt = DateFormatter()
        fmt.timeStyle = .short
        let start = fmt.string(from: event.startDate)
        let end = fmt.string(from: event.endDate)
        return "\(start) – \(end)"
    }
}
