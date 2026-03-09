import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var auth: AuthModel
    @EnvironmentObject var services: ServicesModel

    var body: some View {
        TabView {
            TodayView(cohort: "fall2025")  
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
                .environmentObject(services)

            CalendarListView(cohort: "fall2025")
                .tabItem {
                    Label("Assignments", systemImage: "list.bullet")
                }
                .environmentObject(services)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .environmentObject(auth)
        }
    }
}
