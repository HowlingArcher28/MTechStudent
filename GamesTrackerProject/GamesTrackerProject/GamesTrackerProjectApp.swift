//
//  GamesTrackerProjectApp.swift
//  GamesTrackerProject
//
//  Created by Zachary Jensen on 12/10/25.
//

import SwiftUI
import SwiftData

@main
struct GamesTrackerProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Game.self, Player.self])
    }
}
