//
//  LessonFeedbackView.swift
//

import SwiftUI

struct LessonFeedbackView: View {
    let lessonID: String
    @State private var feedback: String = ""
    @State private var alertMessage: LessonFeedbackAlert?

    @EnvironmentObject var auth: AuthModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Feedback for lesson \(lessonID)")
                    .font(.title2)
                    .bold()

                TextEditor(text: $feedback)
                    .frame(height: 200)
                    .border(Color.gray.opacity(0.3), width: 1)
                    .padding(.bottom, 20)

                Button("Submit Feedback") {
                    Task {
                        await submitFeedback()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Lesson Feedback")
            .alert(item: $alertMessage) { alert in
                Alert(
                    title: Text("Error"),
                    message: Text(alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    @MainActor
    private func submitFeedback() async {
        guard !feedback.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = LessonFeedbackAlert(message: "Feedback cannot be empty.")
            return
        }

        do {
            // Call your API here, e.g.:
            // let response = try await apiClient.submitFeedback(lessonID: lessonID, feedback: feedback)
            print("Feedback submitted for lesson \(lessonID): \(feedback)")
            feedback = ""
        } catch {
            alertMessage = LessonFeedbackAlert(message: error.localizedDescription)
        }
    }
}

// Namespaced alert type for this view only
struct LessonFeedbackAlert: Identifiable {
    let id = UUID()
    let message: String
}
