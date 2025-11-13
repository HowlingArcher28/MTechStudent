//
//  Calender_appApp.swift
//  Calender app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

@main
struct Calender_appApp: App {
    @StateObject private var eventStore = LocalEventStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(eventStore)
        }
    }
}
