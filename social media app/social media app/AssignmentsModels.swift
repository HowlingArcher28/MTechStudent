/*
 AssignmentsModels.swift
 
 Overview:
 Data transfer object (DTO) models representing assignments and FAQs as returned
 by the backend API. These types are Codable for easy encoding/decoding and
 Identifiable for convenient SwiftUI usage.
 
 Contents:
 - AssignmentResponseDTO: The core assignment payload including metadata and FAQs.
 - FAQResponseDTO: Frequently asked questions associated with an assignment or lesson.
*/

import Foundation

struct AssignmentResponseDTO: Codable, Identifiable {
    let id: String
    let name: String
    let assignmentType: String
    let body: String?
    let assignedOn: String?
    let dueOn: String?
    let userProgress: String?
    let faqs: [FAQResponseDTO]
}

struct FAQResponseDTO: Codable, Identifiable {
    let id: String
    let assignmentID: String?
    let lessonID: String?
    let question: String
    let answer: String
    let lastEditedOn: String?
    let lastEditedBy: String?
}
