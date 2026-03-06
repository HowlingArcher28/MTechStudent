import SwiftUI

struct LessonFeedbackView: View {
    @Environment(ServicesModel.self) private var services
    @Environment(AuthModel.self) private var auth
    @Environment(\.dismiss) private var dismiss

    let lessonID: String

    @State private var comments: String = ""
    @State private var rating: Int = 5
    @State private var isSubmitting = false
    @State private var error: String?
    @State private var success = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Rating") {
                    Picker("Rating", selection: $rating) {
                        ForEach(1...5, id: \.self) { n in
                            Text("\(n) Stars").tag(n)
                        }
                    }
                }
                Section("Comments") {
                    TextEditor(text: $comments)
                        .frame(minHeight: 120)
                }
                if let error { Section { Text(error).foregroundStyle(.red) } }
                if success { Section { Label("Thank you for your feedback!", systemImage: "checkmark.seal") } }
            }
            .navigationTitle("Lesson Feedback")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") { Task { await submit() } }
                        .disabled(isSubmitting || comments.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func submit() async {
        isSubmitting = true
        defer { isSubmitting = false }
        do {
            try await services.api.submitLessonFeedback(lessonID: lessonID, rating: rating, comments: comments)
            success = true
            error = nil
        } catch {
            success = false
            self.error = (error as NSError).localizedDescription
        }
    }
}

#Preview {
    let services = ServicesModel()
    let auth = AuthModel(services: services)
    return LessonFeedbackView(lessonID: "example")
        .environment(services)
        .environment(auth)
}
