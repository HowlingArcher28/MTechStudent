//
//  NewTripView.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct NewTripScreen: View {
    @Environment(\.modelContext) private var modelContext

    @State private var tripName: String = ""
    @State private var createdTrip: Trip?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("First, give a name to your trip.")
                .font(.title2)
                .fontWeight(.bold)

            TextField("Trip name", text: $tripName)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

            Spacer()

            Button("Next") {
                let trimmed = tripName.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                let trip = Trip(name: trimmed)
                modelContext.insert(trip)
                createdTrip = trip
            }
            .buttonStyle(.borderedProminent)
            .disabled(tripName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .navigationTitle("New Trip")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $createdTrip) { trip in
            PlacePinScreen(trip: trip)
        }
    }
}

#Preview {
    NavigationStack {
        NewTripScreen()
            .modelContainer(ModelContainer.preview)
    }
}
