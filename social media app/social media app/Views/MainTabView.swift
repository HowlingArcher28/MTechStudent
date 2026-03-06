import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var auth: AuthModel
    @EnvironmentObject var services: ServicesModel

    var body: some View {
        TabView {
            TodayView(cohort: "default")
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
                .environmentObject(services)

            CalendarListView(cohort: "default")
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
