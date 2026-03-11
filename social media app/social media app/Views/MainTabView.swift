/*
 MainTabView.swift
 
 Overview:
 The primary tab container for the app. Hosts Today, Assignments, and Profile
 tabs and reads shared models from the environment.
*/

import SwiftUI

struct MainTabView: View {

    @Environment(AuthModel.self) var auth: AuthModel
    @Environment(ServicesModel.self) var services: ServicesModel

    var body: some View {
        TabView {
            TodayView(cohort: "fall2025")  
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }

            CalendarListView(cohort: "fall2025")
                .tabItem {
                    Label("Assignments", systemImage: "list.bullet")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

