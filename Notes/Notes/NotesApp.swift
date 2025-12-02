//
//  NotesApp.swift
//  Notes
//
//  Created by Zachary Jensen on 12/2/25.
//

import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
