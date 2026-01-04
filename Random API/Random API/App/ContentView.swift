//
//  ContentView.swift
//  Random API
//
//  Created by Zachary Jensen on 1/4/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DogView(viewModel: DogViewModel(api: DogAPIController()))
                .tabItem {
                    Label("Dogs", systemImage: "pawprint.fill")
                }

            RepresentativeView(viewModel: RepresentativeViewModel(api: RepresentativeAPIController()))
                .tabItem {
                    Label("Representatives", systemImage: "person.3.fill")
                }
        }
        .tint(.teal)
    }
}

#Preview {
    ContentView()
}
