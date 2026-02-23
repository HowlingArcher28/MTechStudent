//
//  UserModel.swift
//  Interview
//
//  Created by Zachary Jensen on 2/23/26.
//
import Foundation

struct Person: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

