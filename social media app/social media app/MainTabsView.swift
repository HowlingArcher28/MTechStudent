import SwiftUI

struct MainTabsView: View {
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

#Preview {
    let api = APIClient(baseURL: URL(string: "https://social-media-app.ryanplitt.com")!)
    let authModel = AuthModel(apiClient: api)
    let servicesModel = ServicesModel(apiClient: api, auth: authModel)
    
    return MainTabsView()
        .environmentObject(authModel)
        .environmentObject(servicesModel)
}
