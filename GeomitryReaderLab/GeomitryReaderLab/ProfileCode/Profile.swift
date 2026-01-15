// Profile.swift
import Foundation

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let systemImageName: String
}
