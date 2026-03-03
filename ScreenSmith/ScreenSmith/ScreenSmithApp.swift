//
//  ScreenSmithApp.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

@main
struct ScreenSmithApp: App {

    @StateObject var navigationManager = NavigationManager()
    @StateObject var pipeline = ImagePipeline()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {

                ImportView()
                    .navigationDestination(for: Screen.self) { screen in

                        switch screen {

                        case .importView:
                            ImportView()

                        case .enhanceView(let image):
                            EnhanceView(image: image)

                        case .perfectFitView(let image):
                            PerfectFitView(image: image)

                        }
                    }
            }
            .environmentObject(navigationManager)
            .environmentObject(pipeline)
        }
    }
}

