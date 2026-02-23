//
//  AppRoot.swift
//  Interview
//
//  Created by Zachary Jensen on 2/23/26.
//
import SwiftUI

@main
struct RandomUserPickerApp: App {
    @State private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}

