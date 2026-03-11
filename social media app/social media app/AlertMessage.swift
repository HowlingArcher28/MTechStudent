/*
 AlertMessage.swift
 
 Overview:
 A lightweight, Identifiable wrapper for user-facing error or info messages
 that can be bound to SwiftUI alerts. Views set this to a non-nil value to
 present an alert and clear it to dismiss.
*/

import Foundation

struct AlertMessage: Identifiable {
    let id = UUID()
    let message: String
}
