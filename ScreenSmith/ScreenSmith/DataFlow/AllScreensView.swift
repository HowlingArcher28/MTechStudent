import SwiftUI

struct AllScreensView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            NeonBackground()
            NavigationStack {
                ZStack {
                    NeonBackground()
                    List {
                        Section("Screens") {
                            NavigationLink("Import") { ImportView() }
                            NavigationLink("Enhance (requires image)") {
                                VStack(spacing: 16) {
                                    Text("Pick an image from Import to continue.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    PrimaryButton(title: "Go to Import")
                                        .onTapGesture {
                                            navigationManager.path.append(Screen.importView)
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
                                            navigationManager.path.append(Screen.importView)
                                        }
                                }
                                .padding()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
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
}

