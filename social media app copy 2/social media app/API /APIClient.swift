import Foundation

class APIClient {
    let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }
    
    // MARK: - Sign In
    func signIn(email: String, password: String) async throws -> SignInResponseDTO {
        let url = baseURL.appendingPathComponent("auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(SignInResponseDTO.self, from: data)
    }
    
    // MARK: - Calendar Today
    func calendarToday(userSecret: String, cohort: String) async throws -> CalendarEntryResponseDTO {
        var components = URLComponents(url: baseURL.appendingPathComponent("calendar/today"), resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(CalendarEntryResponseDTO.self, from: data)
    }
    
    // MARK: - Calendar All
    func calendarAll(userSecret: String, cohort: String) async throws -> [CalendarEntryResponseDTO] {
        var components = URLComponents(url: baseURL.appendingPathComponent("calendar/all"), resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode([CalendarEntryResponseDTO].self, from: data)
    }
    
    // MARK: - Get Assignment
    func getAssignment(userSecret: String, id: String, includeProgress: Bool = true, includeFAQs: Bool = true) async throws -> AssignmentResponseDTO {
        var components = URLComponents(url: baseURL.appendingPathComponent("assignment/\(id)"), resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "includeProgress", value: String(includeProgress)),
            URLQueryItem(name: "includeFAQs", value: String(includeFAQs))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(AssignmentResponseDTO.self, from: data)
    }
    
    // MARK: - Get All Assignments
    func assignmentsAll(userSecret: String, cohort: String, includeProgress: Bool = true, includeFAQs: Bool = true) async throws -> [AssignmentResponseDTO] {
        var components = URLComponents(url: baseURL.appendingPathComponent("assignment/all"), resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "includeProgress", value: String(includeProgress)),
            URLQueryItem(name: "includeFAQs", value: String(includeFAQs)),
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode([AssignmentResponseDTO].self, from: data)
    }
    
    // MARK: - Update Assignment Progress
    func updateAssignmentProgress(userSecret: String, assignmentID: String, progress: String) async throws -> AssignmentResponseDTO {
        let url = baseURL.appendingPathComponent("assignment/progress")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
        
        let body = [
            "assignmentID": assignmentID,
            "progress": progress
        ]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(AssignmentResponseDTO.self, from: data)
    }
    
    // MARK: - Error Handling
    private func handleErrors(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrorDTO(message: "Invalid response")
        }
        
        print("Status: \(httpResponse.statusCode), Response: \(String(data: data, encoding: .utf8) ?? "nil")")
        
        if httpResponse.statusCode >= 400 {
            if let apiError = try? JSONDecoder().decode(APIErrorDTO.self, from: data) {
                throw apiError
            }
            throw APIErrorDTO(message: "Server error: \(httpResponse.statusCode)")
        }
    }
}
