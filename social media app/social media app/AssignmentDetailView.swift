/*
 AssignmentDetailView.swift
 
 Overview:
 A SwiftUI screen responsible for presenting the details of a single assignment.
 It fetches the assignment asynchronously from a services layer when the view
 appears, renders the name, optional due date, and any FAQs, and surfaces
 errors to the user using a SwiftUI alert bound to lightweight alert state.
 
 Responsibilities:
 - Coordinate data loading for a specific assignment ID.
 - Render assignment properties in a simple vertical layout.
 - Gracefully handle loading state with a ProgressView.
 - Present errors using `.alert(item:)` when loading fails.
 
 Data Flow:
 - Input: `assignmentID` identifies which assignment to load.
 - Environment: `ServicesModel` performs the fetch; `AuthModel` is available if needed.
 - State: `assignment` holds loaded data; `alertMessage` drives error alerts.
 
 Error Handling:
 - Any thrown error during loading is captured and shown via an alert with a
   human-readable message.
*/

import SwiftUI       // SwiftUI provides the declarative UI primitives used to build this screen.
import Foundation    // Foundation supplies `Date`, `ISO8601DateFormatter`, and other core utilities.
import Combine       // Combine is included for potential publisher-based extensions (not required here).

/// A minimal model used to drive SwiftUI alerts via `.alert(item:)`.
/// Conformance to `Identifiable` allows SwiftUI to present/dismiss the alert automatically.
struct AssignmentAlertMessage: Identifiable {
    /// A stable identity for the alert instance so SwiftUI can track presentation state.
    let id = UUID()
    /// The human-readable error text that will be shown inside the alert message body.
    let message: String
}

/// A view that loads and renders the details of a specific assignment.
/// It fetches data asynchronously when the view appears and shows an error alert on failure.
struct AssignmentDetailView: View {
    // MARK: - Inputs

    /// The unique identifier for the assignment to fetch and display.
    /// This is provided by the parent view or navigation context.
    let assignmentID: String

    // MARK: - State

    /// Holds the loaded assignment data. `nil` while loading or when unavailable.
    @State private var assignment: AssignmentResponseDTO?
    /// When set, triggers presentation of an error alert to the user.
    @State private var alertMessage: AssignmentAlertMessage?

    // MARK: - Environment

    /// The authenticated user/session model provided by the app's environment.
    /// Not currently used in this view, but available for conditional logic if needed.
    @Environment(AuthModel.self) private var auth
    /// The services container used to perform network/data operations.
    /// Type-based `@Environment` access means we reference `services` directly (no `$services`).
    @Environment(ServicesModel.self) private var services

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // If we have successfully loaded an assignment, render its details.
            if let assignment = assignment {

                // Assignment name/title displayed prominently.
                Text(assignment.name)
                    .font(.title2)
                    .bold()

                // Optional due date—only shown if available from the backend.
                // We parse the ISO 8601 string into a `Date` and format it for display.
                if let dueOn = assignment.dueOn,
                   let dueDate = ISO8601DateFormatter().date(from: dueOn) {
                    Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                // FAQs section, rendered only when the assignment has FAQs to show.
                if !assignment.faqs.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("FAQs")
                            .font(.headline)

                        ForEach(assignment.faqs, id: \.id) { faq in
                            Text(faq.question)
                                .font(.subheadline)
                        }
                    }
                }

            } else {
                // While the data is being fetched or when `assignment` is nil, show a progress indicator.
                ProgressView()
            }
        }
        // `.task` runs when the view appears and may re-run if the task is invalidated by SwiftUI.
        .task {
            await loadAssignment()
        }
        // Present an alert whenever `alertMessage` becomes non-nil.
        // Explicitly constructing `Alert` avoids any closure type inference issues.
        .alert(item: $alertMessage) { alert in
            Alert(
                title: Text("Error"),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - Data Loading

    /// Loads the assignment on the main actor (safe to mutate view state) and updates UI state.
    @MainActor
    private func loadAssignment() async {
        do {
            // Attempt to fetch the assignment from the services layer using the provided ID.
            assignment = await services.fetchAssignment(id: assignmentID)
        } catch {
            // On failure, capture the error message and present it to the user via an alert.
            alertMessage = AssignmentAlertMessage(message: error.localizedDescription)
        }
    }
}
