import Foundation

extension APIClient {
    
    /// Fetch all assignments for a cohort
    public func assignmentsAll(cohort: String) async throws -> [AssignmentResponseDTO] {
        let url = "assignments?cohort=\(cohort)"
        let result: [AssignmentResponseDTO] = try await request(url, method: "GET")
        return result
    }
    
    /// Fetch a single assignment by ID
    public func assignmentGet(id: String) async throws -> AssignmentResponseDTO {
        let url = "assignments/\(id)"
        let result: AssignmentResponseDTO = try await request(url, method: "GET")
        return result
    }
}
