/*
 CalendarListView.swift
 
 Overview:
 A SwiftUI screen that lists assignments in a scrollable view. It loads data
 from ServicesModel, renders each item with AssignmentCard, and presents errors
 via a SwiftUI alert.
*/

import SwiftUI

struct CalendarListView: View {

    @Environment(ServicesModel.self) var services: ServicesModel
    let cohort: String

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                if services.allAssignments.isEmpty {
                    ProgressView("Loading assignments...")
                        .tint(AppTheme.primaryRed)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(services.allAssignments, id: \.id) { assignment in
                                AssignmentCard(assignment: assignment)
                            }
                        }
                        .padding()
                    }
                }
            }
            .task {
                if services.allAssignments.isEmpty {
                    await services.loadAll(cohort: cohort)
                }
            }
            .alert(item: Binding(get: { services.alertMessage }, set: { services.alertMessage = $0 })) { alert in
                Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Assignments")
        }
        .appTheme()
    }
}

// MARK: - Assignment Card Component
struct AssignmentCard: View {
    let assignment: AssignmentResponseDTO
    
    private var dueDate: Date? {
        guard let dueOn = assignment.dueOn else { return nil }
        return ISO8601DateFormatter().date(from: dueOn)
    }
    
    private var isOverdue: Bool {
        guard let date = dueDate else { return false }
        return date < Date()
    }
    
    private var assignmentTypeIcon: String {
        switch assignment.assignmentType.lowercased() {
        case "project": return "folder.fill"
        case "quiz", "test": return "checkmark.circle.fill"
        case "reading": return "book.fill"
        default: return "doc.text.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 14) {
            // Type Icon
            Image(systemName: assignmentTypeIcon)
                .font(.title2)
                .foregroundStyle(AppTheme.primaryRed)
                .frame(width: 44, height: 44)
                .background(AppTheme.primaryRed.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(assignment.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    Text(assignment.assignmentType.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    if let date = dueDate {
                        Text("•")
                            .foregroundStyle(.secondary)
                        
                        Label(date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(isOverdue ? .red : .secondary)
                    }
                }
            }
            
            Spacer()
            
            // Status indicator
            if isOverdue {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundStyle(.red)
            } else {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding()
        .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isOverdue ? AnyShapeStyle(Color.red.opacity(0.3)) : AnyShapeStyle(FunTheme.accentGradient.opacity(0.2)), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

