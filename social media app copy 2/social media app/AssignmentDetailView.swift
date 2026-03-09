import SwiftUI
import Foundation
import Combine

struct AssignmentAlertMessage: Identifiable {
    let id = UUID()
    let message: String
}

struct AssignmentDetailView: View {
    
    let assignmentID: String
    
    @State private var assignment: AssignmentResponseDTO?
    @State private var alertMessage: AssignmentAlertMessage?
    
    @EnvironmentObject var auth: AuthModel
    @EnvironmentObject var services: ServicesModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if let assignment = assignment {
                
                Text(assignment.name)
                    .font(.title2)
                    .bold()
                
                if let dueOn = assignment.dueOn,
                   let dueDate = ISO8601DateFormatter().date(from: dueOn) {
                    Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.footnote)
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
        .task {
            await loadAssignment()
        }
        .alert(item: $alertMessage) { alert in
            Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
        }
    }
    
    @MainActor
    private func loadAssignment() async {
        do {
            assignment = await services.fetchAssignment(id: assignmentID)
        } catch {
            alertMessage = AssignmentAlertMessage(message: error.localizedDescription)
        }
    }
}
