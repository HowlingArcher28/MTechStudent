//
//  UserProfile.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import Foundation

struct UserProfile: Equatable, Codable {
    var firstName: String
    var lastName: String
    var username: String
    var bio: String

    var profileImageName: String?
    var coverImageName: String?
}
