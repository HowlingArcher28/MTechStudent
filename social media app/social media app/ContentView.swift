import SwiftUI

struct ContentView: View {

    @EnvironmentObject var services: ServicesModel

    var body: some View {
        NavigationView {
            AssignmentsView(cohort: "default")
                .environmentObject(services)
        }
    }
}
