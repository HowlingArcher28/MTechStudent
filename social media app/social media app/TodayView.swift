import SwiftUI

struct TodayView: View {

    @EnvironmentObject var services: ServicesModel
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
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Header Card
                            TodayHeaderCard()
                            
                            // Stats Row
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
            .alert(item: $services.alertMessage) { alert in
                Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Today")
        }
        .appTheme()
    }
    
    // MARK: - Computed Properties
    private var todayAssignments: [AssignmentResponseDTO] {
        let calendar = Calendar.current
        return services.allAssignments.filter { assignment in
            guard let dueOn = assignment.dueOn,
                  let date = ISO8601DateFormatter().date(from: dueOn) else { return false }
            return calendar.isDateInToday(date)
        }
    }
    
    private var dueSoonCount: Int {
        let calendar = Calendar.current
        let threeDaysFromNow = calendar.date(byAdding: .day, value: 3, to: Date()) ?? Date()
        return services.allAssignments.filter { assignment in
            guard let dueOn = assignment.dueOn,
                  let date = ISO8601DateFormatter().date(from: dueOn) else { return false }
            return date > Date() && date <= threeDaysFromNow
        }.count
    }
    
    private var overdueCount: Int {
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
