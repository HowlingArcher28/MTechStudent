//
//  MainTabsView.swift
//  social media app
//
//  Created by Zachary Jensen on 2/20/26.
//

import SwiftUI

struct MainTabsView: View {
    @Environment(AppModel.self) private var model
    @Environment(ServicesModel.self) private var services
    @Environment(AuthModel.self) private var auth

    var body: some View {
        TabView {
            NavigationStack {
                TodayView()
                    .environment(model)
                    .environment(services)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Today")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Today", systemImage: "calendar.circle")
            }

            NavigationStack {
                CalendarListView()
                    .environment(model)
                    .environment(services)
                    .toolbarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(AppTheme.primaryRed, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Calendar")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                        }
                    }
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }

            NavigationStack {
                SettingsView()
                    .environment(model)
                    .environment(services)
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
    }
}

#Preview {
    let services = ServicesModel()
    let auth = AuthModel(services: services)
    let model = AppModel()
    return MainTabsView()
        .environment(model)
        .environment(services)
        .environment(auth)
}
