/*
 CalendarModels.swift
 
 Overview:
 DTO models for calendar-related API responses. Represents daily entries that
 may include lesson metadata and assignment groupings used by calendar views.
*/

import Foundation

struct CalendarEntryResponseDTO: Codable, Identifiable {
    let id: String
    let date: String
    let holiday: Bool
    let dayID: String?
    let lessonName: String?
    let lessonID: String?
    let mainObjective: String?
    let readingDue: String?
    let assignmentsDue: [AssignmentResponseDTO]?
    let newAssignments: [AssignmentResponseDTO]?
    let dailyCodeChallengeName: String?
    let wordOfTheDay: String?
}

