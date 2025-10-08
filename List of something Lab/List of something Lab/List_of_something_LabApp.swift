//
//  List_of_something_LabApp.swift
//  List of something Lab
//
//  Created by Zachary Jensen on 10/7/25.
//

import SwiftUI

@main
struct List_of_something_LabApp: App {
    @StateObject private var store = QuoteStore()

    var body: some Scene {
        WindowGroup {
            FirstView()
                .environmentObject(store)
        }
    }
}
