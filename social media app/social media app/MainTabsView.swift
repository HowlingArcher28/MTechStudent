//
//  MainTabsView.swift
//

import SwiftUI

struct MainTabsView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            TodayView()
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }

            AssignmentsView()
                .tabItem {
                    Label("Assignments", systemImage: "book")
                }
        }
    }
}

#Preview {
    MainTabsView()
}
