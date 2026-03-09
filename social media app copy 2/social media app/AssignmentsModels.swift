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
