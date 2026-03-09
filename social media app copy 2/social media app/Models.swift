import Foundation

struct SignInResponseDTO: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let userUUID: String
    let secret: String
    let userName: String
}

struct UserProfileDTO: Codable {
    let firstName: String
    let lastName: String
    let userName: String
    let userUUID: String
    let bio: String?
    let techInterests: String?
    let posts: [PostDTO]?
}

struct PostDTO: Codable {
    let postid: Int
    let title: String
    let body: String
    let authorUserName: String
    let authorUserId: String
    let likes: Int
    let userLiked: Bool
    let numComments: Int
    let createdDate: String
    let comments: [CommentDTO]?
}

struct CommentDTO: Codable {
    let commentId: Int
    let body: String
    let userName: String
    let userId: String
    let createdDate: String
}

struct APIErrorDTO: Codable, Error {
    let message: String
}
