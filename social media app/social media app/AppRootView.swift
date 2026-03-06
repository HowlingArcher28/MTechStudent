import SwiftUI

struct AppRootView: View {

    @StateObject private var auth: AuthModel

    @StateObject private var services: ServicesModel

    init() {
        let api = APIClient(baseURL: URL(string: "https://social-media-app.ryanplitt.com")!)
        let authModel = AuthModel(apiClient: api)
        _auth = StateObject(wrappedValue: authModel)
        _services = StateObject(wrappedValue: ServicesModel(apiClient: api, auth: authModel))
    }

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
