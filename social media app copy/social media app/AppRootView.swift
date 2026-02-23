//import SwiftUI
//
//struct AppRootView: View {
//    @State private var services: ServicesModel
//    @State private var auth: AuthModel
//    @State private var model = AppModel()
//
//    init() {
//        _services = State(initialValue: ServicesModel())
//        let services = self.services
//        _auth = State(initialValue: AuthModel(services: services))
//    }
//
//    var body: some View {
//        ContentView()
//            .environment(model)
//            .environment(services)
//            .environment(auth)
//    }
//}
//
//#Preview {
//    AppRootView()
//}

import SwiftUI

struct AppRootView: View {
    @State private var services: ServicesModel
    @State private var auth: AuthModel
    @State private var model = AppModel()

    init() {
        let services = ServicesModel()
        let auth = AuthModel(services: services)

        _services = State(initialValue: services)
        _auth = State(initialValue: auth)
    }

    var body: some View {
        ContentView()
            .environment(model)
            .environment(services)
            .environment(auth)
    }
}

#Preview {
    AppRootView()
}
