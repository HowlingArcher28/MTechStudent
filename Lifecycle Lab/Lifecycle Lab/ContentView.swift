//
//  ContentView.swift
//  Lifecycle Lab
//
//  Created by Zachary Jensen on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var events: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ForEach(events, id: \.self) { event in
                    Text(event)
                }
                
            }
            .padding()
            .onAppear {
                events.append("Content View appeared")
            }
            .onDisappear {
                events.append("Content view disapeared")
            }
        }
        .onChange(of: scenePhase) { oldValue, newPhase in
            switch newPhase {
            case .inactive:
                events.append("App is Inactive")
            case .active:
                events.append("App is Active")
            case .background:
                events.append("App backgrounded")
            @unknown default:
                events.append("error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("iPhone 15 - Light")
                .previewDevice("iPhone 15")
                .preferredColorScheme(.light)
            
            ContentView()
                .previewDisplayName("iPhone SE (3rd gen) - Dark")
                .previewDevice("iPhone SE (3rd generation)")
                .preferredColorScheme(.dark)
        }
    }
}
