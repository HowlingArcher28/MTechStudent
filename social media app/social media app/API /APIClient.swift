import Foundation

struct APIClient {
    struct Configuration {
        var baseURL: URL
        var additionalHeaders: [String: String] = [:]
        var useMockResponses: Bool = false
    }

    var configuration: Configuration

    init(
        baseURL: URL = URL(string: "https://social-media-app.ryanplitt.com")!,
        additionalHeaders: [String: String] = [:],
        useMockResponses: Bool = false
    ) {
        self.configuration = Configuration(
            baseURL: baseURL,
            additionalHeaders: additionalHeaders,
            useMockResponses: useMockResponses
        )
    }

    mutating func setBearerToken(_ token: String?) {
        if let token, !token.isEmpty {
            configuration.additionalHeaders["Authorization"] = "Bearer \(token)"
        } else {
            configuration.additionalHeaders.removeValue(forKey: "Authorization")
        }
    }

    mutating func setUserSecret(_ secret: String?) {
        if let secret, !secret.isEmpty {
            configuration.additionalHeaders["userSecret"] = secret
        } else {
            configuration.additionalHeaders.removeValue(forKey: "userSecret")
        }
    }

    // MARK: - Request Builder

    private func makeRequest(
        path: String,
        method: String = "GET",
        query: [URLQueryItem] = [],
        jsonBody: [String: Any]? = nil,
        headers: [String: String] = [:]
    ) throws -> URLRequest {

        var components = URLComponents(url: configuration.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = query.isEmpty ? nil : query

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Common headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // Additional headers
        configuration.additionalHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        // Only POST/PUT/PATCH get a JSON body
        if method != "GET", let jsonBody {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
        }

        return request
    }

    // MARK: - Perform Request

    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200..<300).contains(http.statusCode) else {
            let serverMessage = String(data: data, encoding: .utf8)
            print("[APIClient] Request failed with status: \(http.statusCode)")
            print("[APIClient] Response body:", serverMessage ?? "<no body>")
            throw NSError(
                domain: "APIClient",
                code: http.statusCode,
                userInfo: [NSLocalizedDescriptionKey: serverMessage ?? "Request failed"]
            )
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("[APIClient] Decoding failed:", error)
            print("[APIClient] Raw response:", String(data: data, encoding: .utf8) ?? "<non-UTF8>")
            throw error
        }
    }
}

// MARK: - Auth API

extension APIClient {
    struct SignInResponseDTO: Decodable {
        let firstName: String
        let lastName: String
        let email: String
        let userUUID: String
        let secret: String
        let userName: String
    }

    func login(email: String, password: String) async throws -> SignInResponseDTO {
        let body = [
            "email": email,
            "password": password
        ]

        let request = try makeRequest(
            path: "auth/login",
            method: "POST",
            jsonBody: body
        )

        return try await performRequest(request)
    }

    func authTest() async throws -> String {
        let request = try makeRequest(path: "auth/test")
        return try await performRequest(request)
    }
}

// MARK: - Calendar API

extension APIClient {

    struct CalendarEntryResponseDTO: Decodable {
        let id: String?
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

    struct AssignmentResponseDTO: Decodable, Identifiable {
        let id: String
        let name: String
        let assignmentType: String
        let body: String?
        let assignedOn: String?
        let dueOn: String?
        let userProgress: String?
        let faqs: [FAQResponseDTO]?
    }

    struct FAQResponseDTO: Decodable, Identifiable {
        let id: String
        let assignmentID: String
        let lessonID: String
        let question: String
        let answer: String
        let lastEditedOn: String
        let lastEditedBy: String
    }

    func calendarToday(cohort: String) async throws -> CalendarEntryResponseDTO {
        let request = try makeRequest(
            path: "calendar/today",
            query: [URLQueryItem(name: "cohort", value: cohort)]
        )
        return try await performRequest(request)
    }

    func calendarAll(cohort: String) async throws -> [CalendarEntryResponseDTO] {
        let request = try makeRequest(
            path: "calendar/all",
            query: [URLQueryItem(name: "cohort", value: cohort)]
        )
        return try await performRequest(request)
    }

    func assignmentsAll(
        cohort: String,
        includeProgress: Bool = true,
        includeFAQs: Bool = false
    ) async throws -> [AssignmentResponseDTO] {

        var query = [URLQueryItem(name: "cohort", value: cohort)]
        if includeProgress { query.append(URLQueryItem(name: "includeProgress", value: "true")) }
        if includeFAQs { query.append(URLQueryItem(name: "includeFAQs", value: "true")) }

        let request = try makeRequest(
            path: "assignment/all",
            query: query
        )

        return try await performRequest(request)
    }
}

