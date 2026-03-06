import SwiftUI
import Combine

@MainActor
class ServicesModel: ObservableObject {
    
    private let apiClient: APIClient
    private let auth: AuthModel
    
    @Published var allAssignments: [AssignmentResponseDTO] = []
    @Published var calendarEntries: [CalendarEntryResponseDTO] = []
    @Published var todayEntry: CalendarEntryResponseDTO?
    @Published var alertMessage: AlertMessage?
    
    init(apiClient: APIClient, auth: AuthModel) {
        self.apiClient = apiClient
        self.auth = auth
    }
    
    // MARK: - Load All Assignments (lightweight)
    func loadAll(cohort: String) async {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            let assignments = try await apiClient.assignmentsAll(
                userSecret: userSecret,
                cohort: cohort,
                includeProgress: false,
                includeFAQs: false
            )
            print("✅ Loaded \(assignments.count) assignments")
            allAssignments = assignments
        } catch let error as APIErrorDTO {
            print("❌ API Error: \(error.message)")
            alertMessage = AlertMessage(message: error.message)
        } catch {
            print("❌ Error: \(error)")
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Load Today Only (lightweight)
    func loadTodayOnly(cohort: String) async {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            todayEntry = try await apiClient.calendarToday(userSecret: userSecret, cohort: cohort)
            print("✅ Loaded today's entry")
        } catch let error as APIErrorDTO {
            print("❌ API Error: \(error.message)")
            alertMessage = AlertMessage(message: error.message)
        } catch {
            print("❌ Error: \(error)")
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Fetch Single Assignment (with full details)
    func fetchAssignment(id: String) async -> AssignmentResponseDTO? {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return nil
        }
        
        do {
            return try await apiClient.getAssignment(userSecret: userSecret, id: id, includeProgress: true, includeFAQs: true)
        } catch let error as APIErrorDTO {
            alertMessage = AlertMessage(message: error.message)
            return nil
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Load Today's Calendar
    func loadToday(cohort: String) async {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            todayEntry = try await apiClient.calendarToday(userSecret: userSecret, cohort: cohort)
        } catch let error as APIErrorDTO {
            alertMessage = AlertMessage(message: error.message)
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Load All Calendar Entries
    func loadCalendar(cohort: String) async {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            calendarEntries = try await apiClient.calendarAll(userSecret: userSecret, cohort: cohort)
        } catch let error as APIErrorDTO {
            alertMessage = AlertMessage(message: error.message)
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Update Assignment Progress
    func updateProgress(assignmentID: String, progress: String) async {
        guard let userSecret = auth.user?.secret else {
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            let updated = try await apiClient.updateAssignmentProgress(userSecret: userSecret, assignmentID: assignmentID, progress: progress)
            if let index = allAssignments.firstIndex(where: { $0.id == assignmentID }) {
                allAssignments[index] = updated
            }
        } catch let error as APIErrorDTO {
            alertMessage = AlertMessage(message: error.message)
        } catch {
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
}
