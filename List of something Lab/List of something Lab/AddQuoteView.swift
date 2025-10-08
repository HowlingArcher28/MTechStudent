import SwiftUI

struct AddQuoteView: View {
    @EnvironmentObject private var store: QuoteStore
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss

    @State private var text: String = ""
    @State private var author: String = ""

    var isSaveDisabled: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Quote")) {
                    TextEditor(text: $text)
                        .frame(minHeight: 120)
                        .overlay {
                            if text.isEmpty {
                                Text("Enter quote...")
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                }
                Section(header: Text("Author")) {
                    TextField("Author (optional)", text: $author)
                }
            }
            .navigationTitle("Add Quote")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Use environment dismiss for reliability across platforms
                        dismiss()
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedAuthor = author.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedText.isEmpty else { return }
                        store.add(text: trimmedText, author: trimmedAuthor)
                        dismiss()
                        isPresented = false
                    }
                    .disabled(isSaveDisabled)
                }
            }
        }
    }
}

#Preview {
    AddQuoteView(isPresented: .constant(true))
        .environmentObject(QuoteStore())
}
