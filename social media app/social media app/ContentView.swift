import SwiftUI

struct ContentView: View {

    @Environment(ServicesModel.self) var services: ServicesModel

    var body: some View {
        NavigationView {
            AssignmentsView(cohort: "default")
        }
    }
}
