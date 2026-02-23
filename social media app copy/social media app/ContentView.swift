//
//  ContentView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @Environment(AppModel.self) private var model
    @Environment(ServicesModel.self) private var services
    @Environment(AuthModel.self) private var auth

    var body: some View {
        Group {
            if auth.isAuthenticated {
                MainTabsView()
            } else {
                LoginView()
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
        .task {
            configureAppearance()
            await auth.restoreSession()
        }
    }
}

private func configureAppearance() {
    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithOpaqueBackground()
    tabBarAppearance.backgroundColor = UIColor(AppTheme.primaryRed)
    tabBarAppearance.shadowColor = .clear
    UITabBar.appearance().standardAppearance = tabBarAppearance
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    UITabBar.appearance().tintColor = .white

    let navAppearance = UINavigationBarAppearance()
    navAppearance.configureWithOpaqueBackground()
    navAppearance.backgroundColor = UIColor(AppTheme.primaryRed)
    navAppearance.shadowColor = .clear
    navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().standardAppearance = navAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    UINavigationBar.appearance().compactAppearance = navAppearance
}

#Preview {
    let services = ServicesModel()
    let auth = AuthModel(services: services)
    let model = AppModel()
    return ContentView()
        .environment(model)
        .environment(services)
        .environment(auth)
}

