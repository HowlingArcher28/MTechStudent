/*
 APIClient.swift
 
 Overview:
 light networking responsible for communicating with the backend
 REST API. Provides async and await methods for authentication, calendar, and
 assignment operations, and does HTTP error handling.
 
 Responsibilities:
 - Build and execute URLRequests for each API endpoint.
 - Decode JSON responses into strongly typed DTOs.
 - Map HTTP errors to APIErrorDTO and throw meaningful errors.
*/

import Foundation

class APIClient { // Talks to the server for us
    // The base address of our backend API (like https://example.com)
    let baseURL: URL
    // Reuses URLSession for all requests
    private let session: URLSession
    
    // We pass in the base URL when we create the client
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }
    
    // MARK: - Sign In
    func signIn(email: String, password: String) async throws -> SignInResponseDTO {
        // Build the URL for the login endpoint
        let url = baseURL.appendingPathComponent("auth/login")
        // Make a POST request to send email/password
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Tell server we're sending JSON
        
        // Create a simple JSON body
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body) // Turn the Swift dictionary into JSON bytes
        
        // Send the request and wait for data back
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data) // Throw if server said it was an error
        return try JSONDecoder().decode(SignInResponseDTO.self, from: data) // Decode JSON into our model (this includes the secret)
    }
    
    // MARK: - Calendar Today
    func calendarToday(userSecret: String, cohort: String) async throws -> CalendarEntryResponseDTO {
        var components = URLComponents(url: baseURL.appendingPathComponent("calendar/today"), resolvingAgainstBaseURL: false)!
        // Add any query parameters the API expects
        components.queryItems = [
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization") // Use the secret as a Bearer token (kept only in memory)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(CalendarEntryResponseDTO.self, from: data) // Decode the JSON response into our DTOs
    }
    
    // MARK: - Calendar All
    func calendarAll(userSecret: String, cohort: String) async throws -> [CalendarEntryResponseDTO] {
        var components = URLComponents(url: baseURL.appendingPathComponent("calendar/all"), resolvingAgainstBaseURL: false)!
        // Add any query parameters the API expects
        components.queryItems = [
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization") // Use the secret as a Bearer token (kept only in memory)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode([CalendarEntryResponseDTO].self, from: data) // Decode the JSON response into our DTOs
    }
    
    // MARK: - Get Assignment
    func getAssignment(userSecret: String, id: String, includeProgress: Bool = true, includeFAQs: Bool = true) async throws -> AssignmentResponseDTO {
        var components = URLComponents(url: baseURL.appendingPathComponent("assignment/\(id)"), resolvingAgainstBaseURL: false)!
        // Add any query parameters the API expects
        components.queryItems = [
            URLQueryItem(name: "includeProgress", value: String(includeProgress)),
            URLQueryItem(name: "includeFAQs", value: String(includeFAQs))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization") // Use the secret as a Bearer token (kept only in memory)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(AssignmentResponseDTO.self, from: data) // Decode the JSON response into our DTOs
    }
    
    // MARK: - Get All Assignments
    func assignmentsAll(userSecret: String, cohort: String, includeProgress: Bool = true, includeFAQs: Bool = true) async throws -> [AssignmentResponseDTO] {
        var components = URLComponents(url: baseURL.appendingPathComponent("assignment/all"), resolvingAgainstBaseURL: false)!
        // Add any query parameters the API expects
        components.queryItems = [
            URLQueryItem(name: "includeProgress", value: String(includeProgress)),
            URLQueryItem(name: "includeFAQs", value: String(includeFAQs)),
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization") // Use the secret as a Bearer token (kept only in memory)
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode([AssignmentResponseDTO].self, from: data) // Decode the JSON response into our DTOs
    }
    
    // MARK: - Update Assignment Progress
    func updateAssignmentProgress(userSecret: String, assignmentID: String, progress: String) async throws -> AssignmentResponseDTO {
        // Endpoint to update progress for an assignment
        let url = baseURL.appendingPathComponent("assignment/progress")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization") // Auth with the secret
        
        // The JSON body the API expects
        let body = [
            "assignmentID": assignmentID,
            "progress": progress
        ]
        request.httpBody = try JSONEncoder().encode(body) // Encode to JSON
        
        let (data, response) = try await session.data(for: request)
        try handleErrors(response: response, data: data)
        return try JSONDecoder().decode(AssignmentResponseDTO.self, from: data) // Par the updated assignment from the server
    }
    
    // MARK: - Error Handling
    private func handleErrors(response: URLResponse, data: Data) throws {
        // Make sur we really got an HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrorDTO(message: "Invalid response")
        }
        
        print("Status: \(httpResponse.statusCode), Response: \(String(data: data, encoding: .utf8) ?? "nil")") // Helpful for debugging status codes and payloads
        
        // For any 4xx/5xx, try to decode a API error
        if httpResponse.statusCode >= 400 {
            if let apiError = try? JSONDecoder().decode(APIErrorDTO.self, from: data) {
                throw apiError // Server sent a structured error message
            }
            throw APIErrorDTO(message: "Server error: \(httpResponse.statusCode)") // Fallback message if we don't have a specific API error
        }
    }
}

