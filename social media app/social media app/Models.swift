/*
 Models.swift
 
 Overview:
 Core DTO models used by the networking layer and views. These types mirror
 backend API payloads for sign-in, user profiles, posts, comments, and generic
 API errors, and are Codable for straightforward JSON encoding/decoding.
 
 Contents:
 - SignInResponseDTO: Auth response containing user identity and secret token.
 - UserProfileDTO: Public profile information and optional posts.
 - PostDTO / CommentDTO: Basic social content types with metadata.
 - APIErrorDTO: A simple error type surfaced when API calls fail.
*/

import Foundation

// This is what the server sends back when you log in (includes your secret)
struct SignInResponseDTO: Codable {
    let firstName: String // User's first name
    let lastName: String // User's last name
    let email: String // Email used to sign in
    let userUUID: String // Unique ID for the user
    let secret: String // IMPORTANT: Token we use to call protected endpoints
    let userName: String // Public username
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

// When something goes wrong, the server may send back this shape
struct APIErrorDTO: Codable, Error {
    let message: String // Human-friendly error message to show in the UI
}

