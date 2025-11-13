//
//  ContentView.swift
//  Calender app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var eventStore: LocalEventStore

    var body: some View {
        NavigationStack {
            CalendarMonthView()
                .navigationTitle("Calendar")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalEventStore())
}
