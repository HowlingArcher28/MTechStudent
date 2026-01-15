//
//  PlacePinScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct PlacePinScreen: View {
    let trip: Trip
    @State private var firstEntry: JournalEntry? // Keep a reference to the newly placed entry
    
    var body: some View {
        VStack {
            MapReader { reader in // Allows conversion of a touch gesture into coordinates
                Map {
                    // Display the pin the user placed
                    if let entry = firstEntry {
                        if let item = entry.location.mapItem {
                            Marker(item: item)
                        } else if let coordinate = entry.location.coordinate {
                            Marker("\(entry.name)", coordinate: coordinate)
                        }
                    }
                }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                placePin(reader: reader, location: value.location)
                            }
                    )
            }
            .overlay(alignment: .bottom) {
                Text("Tap anywhere on the map to place a pin.")
                    .font(.footnote)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding()
                    .allowsHitTesting(false) // ensure overlay doesn't block map taps
            }
        }
        .navigationTitle("Place Pin")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let entry = firstEntry {
                    NavigationLink("Next") {
                        SetUpPinScreen(trip: trip, entry: entry)
                    }
                } else {
                    Button("Next") {}
                        .disabled(true)
                }
            }
        }
    }
    
    func placePin(reader: MapProxy, location: CGPoint) {
        guard let coordinate = reader.convert(location, from: .local) else { return }

        // If already created an entry in this screen, update its location instead of creating a new one.
        if let existing = firstEntry {
            existing.location.latitude = coordinate.latitude
            existing.location.longitude = coordinate.longitude
            return
        }

        // Otherwise, create a single new entry and keep a reference to it.
        let loc = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let journalEntry = JournalEntry(name: "Stop Name", location: loc)
        journalEntry.trip = trip
        trip.journalEntries.append(journalEntry)
        firstEntry = journalEntry
    }
}

#Preview {
    PlacePinScreen(trip: Trip.mock())
        .modelContainer(ModelContainer.preview)
}

