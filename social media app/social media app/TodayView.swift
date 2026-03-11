/*
 TodayView.swift
 
 Overview:
 A SwiftUI dashboard for "Today" that shows a header with the current date,
 summary of things like statistics for assignments (total, due soon, overdue), and a list of
 assignments due today. loads data from the shared ServicesModel and presents
 errors from a SwiftUI alert. Also a background view that provides the app's themed styling.
 
 Responsibilities:
 - Trigger a lightweight load of all assignments when data is empty.
 - Compute today/due-soon/overdue counts from assignment due dates.
 - Render cards and tiles for a friendly, glanceable overview.
 - Surface errors from ServicesModel.alertMessage.
*/
import SwiftUI

struct TodayView: View {

    // gets the shared services so we can read assignments and errors
    @Environment(ServicesModel.self) var services: ServicesModel
    let cohort: String

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                if services.allAssignments.isEmpty {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(AppTheme.primaryRed)
                        Text("Loading today's assignments...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .task {
                        await services.loadAll(cohort: cohort)
                    } // starts loading when the view appears
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Header Card
                            TodayHeaderCard()
                            
                            // Show quick stats so users can see what's coming up
                            HStack(spacing: 12) {
                                StatTile(
                                    title: "Total",
                                    value: "\(services.allAssignments.count)",
                                    emoji: "📚"
                                )
                                StatTile(
                                    title: "Due Soon",
                                    value: "\(dueSoonCount)",
                                    emoji: "⏰"
                                )
                                StatTile(
                                    title: "Overdue",
                                    value: "\(overdueCount)",
                                    emoji: "⚠️"
                                )
                            }
                            
                            // Assignments Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Today's Assignments")
                                    .font(.title3)
                                    .bold()
                                    .padding(.horizontal, 4)
                                
                                if todayAssignments.isEmpty {
                                    EmptyStateCard(
                                        icon: "checkmark.circle",
                                        title: "All Clear!",
                                        message: "No assignments due today."
                                    )
                                } else {
                                    ForEach(todayAssignments, id: \.id) { assignment in
                                        AssignmentCard(assignment: assignment)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .alert("Error", isPresented: Binding(
                get: { services.alertMessage != nil },
                set: { if !$0 { services.alertMessage = nil } }
            )) {
                Button("OK", role: .cancel) {
                    services.alertMessage = nil
                }
            } message: {
                Text(services.alertMessage?.message ?? "")
            } // Present an alert whenever ServicesModel has an alert message
            .navigationTitle("Today")
        }
        .appTheme()
    }
    
    // MARK: - Computed Properties
    private var todayAssignments: [AssignmentResponseDTO] {
        // Figure out which assignments have a due date that is 'today'
        let calendar = Calendar.current
        return services.allAssignments.filter { assignment in
            guard let dueOn = assignment.dueOn,
                  let date = ISO8601DateFormatter().date(from: dueOn) else { return false }
            return calendar.isDateInToday(date)
        }
    }
    
    private var dueSoonCount: Int {
        // We count anything due in the next 3 days as 'soon'
        let calendar = Calendar.current
        let threeDaysFromNow = calendar.date(byAdding: .day, value: 3, to: Date()) ?? Date()
        return services.allAssignments.filter { assignment in
            guard let dueOn = assignment.dueOn,
                  let date = ISO8601DateFormatter().date(from: dueOn) else { return false }
            return date > Date() && date <= threeDaysFromNow
        }.count
    }
    
    private var overdueCount: Int {
        // Anything with a due date in the past is overdue
        services.allAssignments.filter { assignment in
            guard let dueOn = assignment.dueOn,
                  let date = ISO8601DateFormatter().date(from: dueOn) else { return false }
            return date < Date()
        }.count
    }
}

// MARK: - Today Header Card
struct TodayHeaderCard: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(Date().formatted(.dateTime.weekday(.wide)))
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(Date().formatted(.dateTime.month().day()))
                .font(.largeTitle)
                .bold()
                .foregroundStyle(AppTheme.primaryRed)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(FunTheme.accentGradient.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
    }
}

// MARK: - Empty State Card
struct EmptyStateCard: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(AppTheme.primaryRed)
            
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(FunTheme.accentGradient.opacity(0.2), lineWidth: 1)
        )
    }
}

