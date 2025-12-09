//
//  ContentView.swift
//  DragonDex
//
//  Created by Zachary Jensen on 12/4/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var themeStore: ThemeStore
    @StateObject private var dragonListVM = DragonListViewModel()
    @StateObject private var powerListVM = PowerListViewModel()
    @State private var isShowingSettings = false

    var body: some View {
        ZStack {
            
            themeStore.background
                .ignoresSafeArea()
                .transaction { txn in
                    txn.animation = nil
                }

            TabView {
                NavigationStack {
                    DragonListView(viewModel: dragonListVM)
                        .navigationTitle("Dragons")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    isShowingSettings = true
                                } label: {
                                    Image(systemName: "gearshape")
                                }
                                .accessibilityLabel("Settings")
                            }
                        }
                }
                .tabItem {
                    Label("Dragons", systemImage: "list.bullet")
                }

                NavigationStack {
                    PowerListView(viewModel: powerListVM)
                        .navigationTitle("Powers")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    isShowingSettings = true
                                } label: {
                                    Image(systemName: "gearshape")
                                }
                                .accessibilityLabel("Settings")
                            }
                        }
                }
                .tabItem {
                    Label("Powers", systemImage: "bolt.fill")
                }
            }
            // Explicitly disable animations triggered by theme changes for this container
            .animation(nil, value: themeStore.selectedTheme)
        }
        .sheet(isPresented: $isShowingSettings) {
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                isShowingSettings = false
                            }
                        }
                    }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeStore())
}
