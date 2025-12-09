//
//  DragonDexApp.swift
//  DragonDex
//
//  Created by Zachary Jensen on 12/4/25.
//

import SwiftUI

@main
struct DragonDexApp: App {
    @StateObject private var themeStore = ThemeStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeStore)
                .preferredColorScheme(themeStore.colorScheme)
                .tint(themeStore.accentColor)
        }
    }
}
