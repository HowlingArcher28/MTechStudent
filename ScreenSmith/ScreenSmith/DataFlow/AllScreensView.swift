import SwiftUI

struct AllScreensView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Screens") {
                    NavigationLink("Import") {
                        ImportView()
                    }
                    NavigationLink("Enhance (requires image)") {
                        VStack(spacing: 16) {
                            Text("Pick an image from Import to continue.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            PrimaryButton(title: "Go to Import")
                                .onTapGesture {
                                    navigationManager.path.append(Screen.importScreen)
                                }
                        }
                        .padding()
                    }
                    NavigationLink("Perfect Fit (requires image)") {
                        VStack(spacing: 16) {
                            Text("Pick an image from Import to continue.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            PrimaryButton(title: "Go to Import")
                                .onTapGesture {
                                    navigationManager.path.append(Screen.importScreen)
                                }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("All Screens")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
