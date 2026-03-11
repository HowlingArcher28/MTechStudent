/*
 ServicesModel.swift
 
 Overview:
 Central observable services container for the app. Coordinates network calls
 via APIClient, exposes lightweight app state (assignments, calendar entries,
 and alerts), and provides convenience methods for fetching and updating data.
 
 Responsibilities:
 - Perform assignment and calendar API requests.
 - Store results for use across SwiftUI views via @Environment(ServicesModel.self).
 - Surface user-facing AlertMessage errors when requests fail.
 - Provide helper methods to update assignment progress.
*/

import SwiftUI
import Combine

@Observable // Makes this class publish changes to SwiftUI views
class ServicesModel {
    
    // Used to call the backend API
    private let apiClient: APIClient
    // Holds the signed-in user (and their secret)
    private let auth: AuthModel
    
    // Cached list of all assignments so multiple screens can use it
    var allAssignments: [AssignmentResponseDTO] = []
    var calendarEntries: [CalendarEntryResponseDTO] = []
    var todayEntry: CalendarEntryResponseDTO?
    // When set, views show an alert with this message
    var alertMessage: AlertMessage?
    
    // We inject our dependencies (API + Auth) when creating this
    init(apiClient: APIClient, auth: AuthModel) {
        self.apiClient = apiClient
        self.auth = auth
    }
    
    // MARK: - Load All Assignments (lightweight)
    func loadAll(cohort: String) async {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            let assignments = try await apiClient.assignmentsAll(
                userSecret: userSecret,
                cohort: cohort,
                includeProgress: false,
                includeFAQs: false
            ) // Ask the API for data
            print("✅ Loaded \(assignments.count) assignments")
            allAssignments = assignments
        } catch let error as APIErrorDTO { // Friendly error from server
            print("❌ API Error: \(error.message)")
            alertMessage = AlertMessage(message: error.message)
        } catch { // Unexpected error (like network issues)
            print("❌ Error: \(error)")
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Load Today Only (lightweight)
    func loadTodayOnly(cohort: String) async {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            todayEntry = try await apiClient.calendarToday(userSecret: userSecret, cohort: cohort) // Ask the API for data
            print("✅ Loaded today's entry")
        } catch let error as APIErrorDTO { // Friendly error from server
            print("❌ API Error: \(error.message)")
            alertMessage = AlertMessage(message: error.message)
        } catch { // Unexpected error (like network issues)
            print("❌ Error: \(error)")
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Fetch Single Assignment (with full details)
    func fetchAssignment(id: String) async -> AssignmentResponseDTO? {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return nil
        }
        
        do {
            return try await apiClient.getAssignment(userSecret: userSecret, id: id, includeProgress: true, includeFAQs: true) // Ask the API for data
        } catch let error as APIErrorDTO { // Friendly error from server
            alertMessage = AlertMessage(message: error.message)
            return nil
        } catch { // Unexpected error (like network issues)
            alertMessage = AlertMessage(message: error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Load Today's Calendar
    func loadToday(cohort: String) async {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            todayEntry = try await apiClient.calendarToday(userSecret: userSecret, cohort: cohort) // Ask the API for data
        } catch let error as APIErrorDTO { // Friendly error from server
            alertMessage = AlertMessage(message: error.message)
        } catch { // Unexpected error (like network issues)
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Load All Calendar Entries
    func loadCalendar(cohort: String) async {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            calendarEntries = try await apiClient.calendarAll(userSecret: userSecret, cohort: cohort) // Ask the API for data
        } catch let error as APIErrorDTO { // Friendly error from server
            alertMessage = AlertMessage(message: error.message)
        } catch { // Unexpected error (like network issues)
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
    
    // MARK: - Update Assignment Progress
    func updateProgress(assignmentID: String, progress: String) async {
        guard let userSecret = auth.user?.secret else { // If not logged in, we can't call protected endpoints
            alertMessage = AlertMessage(message: "User not signed in")
            return
        }
        
        do {
            let updated = try await apiClient.updateAssignmentProgress(userSecret: userSecret, assignmentID: assignmentID, progress: progress) // Ask the API for data
            // Update our cached array so UI refreshes with the new data
            if let index = allAssignments.firstIndex(where: { $0.id == assignmentID }) {
                allAssignments[index] = updated
            }
        } catch let error as APIErrorDTO { // Friendly error from server
            alertMessage = AlertMessage(message: error.message)
        } catch { // Unexpected error (like network issues)
            alertMessage = AlertMessage(message: error.localizedDescription)
        }
    }
}

