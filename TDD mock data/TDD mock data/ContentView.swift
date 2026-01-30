import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("User Manager Demo").font(.title)
            UserManagerDemoView()
        }
        .padding()
    }
}

#Preview { ContentView() }

// MARK: - Minimal domain for demo

struct UserManagerDemoView: View {
    @State private var names: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if names.isEmpty {
                Text("No users yet").foregroundStyle(.secondary)
            } else {
                ForEach(names, id: \.self) { Text($0) }
            }
            Button("Load Demo Users") { Task { await load() } }
                .buttonStyle(.borderedProminent)
        }
        .task { await load() }
    }

    private func load() async {
        let fake = FakeUserService(seed: [User(name: "Zara"), User(name: "Milo"), User(name: "Ava")])
        let manager = UserManager(service: fake)
        names = (try? await manager.sortedUserNames()) ?? ["Error loading users"]
    }
}

#Preview("Demo View") { UserManagerDemoView() }

