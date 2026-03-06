import SwiftUI
import Foundation
import Combine

struct AssignmentDetailView: View {
    
    let assignmentID: String
    
    @State private var assignment: AssignmentResponseDTO?
    @State private var alertMessage: AlertMessage?
    
    @EnvironmentObject var auth: AuthModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if let assignment = assignment {
                
                Text(assignment.name)
                    .font(.title2)
                    .bold()
                
                if let dueDate = ISO8601DateFormatter().date(from: assignment.dueOn) {
                    Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
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
                ProgressView()
            }
        }
        .padding()
        .task {
            await loadAssignment()
        }
        .alert(item: $alertMessage) { (alert: AlertMessage) in
            Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
        }
    }
    
    @MainActor
    private func loadAssignment() async {
        do {
            // Use API through AuthModel
            assignment = try await auth.api.assignmentGet(id: assignmentID)
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
}
