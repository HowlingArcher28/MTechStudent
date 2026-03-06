import SwiftUI

struct AppRootView: View {

    // AuthModel gets an APIClient
    @StateObject private var auth = AuthModel(
        apiClient: APIClient(baseURL: URL(string: "https://social-media-app.ryanplitt.com")!)
    )

    // ServicesModel also gets an APIClient
    @StateObject private var services = ServicesModel(
        apiClient: APIClient(baseURL: URL(string: "https://social-media-app.ryanplitt.com")!)
    )

    var body: some View {
        Group {
            if auth.isLoggedIn {
                MainTabView()
                    .environmentObject(auth)
                    .environmentObject(services)
            } else {
                LoginView()
                    .environmentObject(auth)
            }
        }
    }
}
