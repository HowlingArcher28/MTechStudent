//
//  ContentView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var model = AppModel()
    @State private var seeded = false

    // Allow injecting a different generator for tests/previews
    private let postGenerator: PostGenerating

    init(postGenerator: PostGenerating = PostSeeder()) {
        self.postGenerator = postGenerator

        // Tab bar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(AppTheme.primaryRed)
        tabBarAppearance.backgroundEffect = nil
        tabBarAppearance.shadowColor = .clear
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white // selected item color

        // Navigation bar
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(AppTheme.primaryRed)
        navAppearance.backgroundEffect = nil
        navAppearance.shadowColor = .clear
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
    }

    var body: some View {
        TabView {
            NavigationStack {
                FeedView()
                    .environmentObject(model)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Feed")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Feed", systemImage: "list.bullet.rectangle")
            }

            NavigationStack {
                ComposeView()
                    .environmentObject(model)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Compose")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Compose", systemImage: "square.and.pencil")
            }

            NavigationStack {
                ProfileView()
                    .environmentObject(model)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Profile")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }

            NavigationStack {
                SettingsView()
                    .environmentObject(model)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Settings")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(AppTheme.primaryRed, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
        .appTheme()
        .task {
            if !seeded {
                let generated = postGenerator.generatePosts(count: 30)
                model.posts.append(contentsOf: generated)
                model.posts.sort { $0.timestamp > $1.timestamp }
                seeded = true
            }
        }
    }
}

#Preview {
    ContentView()
}
