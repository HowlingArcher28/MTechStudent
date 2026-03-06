import Foundation

class APIClient {
    let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }
    
    private func request<T: Decodable>(_ endpoint: String, method: String = "GET", body: Data? = nil, queryItems: [URLQueryItem]? = nil) async throws -> T {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrorDTO(message: "Invalid response")
        }
        
        if httpResponse.statusCode >= 400 {
            let apiError = try? JSONDecoder().decode(APIErrorDTO.self, from: data)
            throw apiError ?? APIErrorDTO(message: "Unknown server error")
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: Sign In
    func signIn(email: String, password: String) async throws -> SignInResponseDTO {
        let body = try JSONEncoder().encode(["email": email, "password": password])
        return try await request("signIn", method: "POST", body: body)
    }
    
    // MARK: User Profile
    func getUserProfile(userUUID: String, userSecret: String) async throws -> UserProfileDTO {
        return try await request("userProfile", queryItems: [
            URLQueryItem(name: "userUUID", value: userUUID),
            URLQueryItem(name: "userSecret", value: userSecret)
        ])
    }
    
    // MARK: Posts
    func getPosts(userSecret: String, pageNumber: Int? = 0) async throws -> [PostDTO] {
        var queryItems = [URLQueryItem(name: "userSecret", value: userSecret)]
        if let page = pageNumber {
            queryItems.append(URLQueryItem(name: "pageNumber", value: "\(page)"))
        }
        return try await request("posts", queryItems: queryItems)
    }
    
    func createPost(userSecret: String, title: String, body: String) async throws -> PostDTO {
        let jsonBody = ["userSecret": userSecret, "post": ["title": title, "body": body]] as [String : Any]
        let data = try JSONSerialization.data(withJSONObject: jsonBody)
        return try await request("createPost", method: "POST", body: data)
    }
}
