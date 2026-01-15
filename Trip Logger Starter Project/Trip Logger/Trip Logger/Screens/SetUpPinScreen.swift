//
//  SetUpPinScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct SetUpPinScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var rootDismiss
    @Bindable var trip: Trip
    @Bindable var entry: JournalEntry
    @State private var goNextPin = false
    let onFinish: (() -> Void)? = nil
    @State private var saveError: Error?
    @State private var showSaveError = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name this pin, add photos, and add notes to this stop")
                .font(.headline)
            
            Group {
                TextField("Pin name", text: $entry.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Notes", text: $entry.text, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
            }
            
            PhotoScrollView(journalEntry: entry)
                .padding(.vertical)
            
            Spacer()
            
            HStack {
                Button("Save & Finish") {
                    do {
                        try modelContext.save()
                        if let onFinish {
                            onFinish()
                        }
                        // Dismiss this screen
                        dismiss()
                        // Also dismiss the parent sheet (New Trip flow)
                        rootDismiss()
                    } catch {
                        saveError = error
                        showSaveError = true
                    }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button("Save & Add Another Pin") {
                    do {
                        try modelContext.save()
                        goNextPin = true
                    } catch {
                        saveError = error
                        showSaveError = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle("Set Up Pin")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Save Failed", isPresented: $showSaveError, presenting: saveError) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
        .navigationDestination(isPresented: $goNextPin) {
            // Replace PlacePinScreen with your actual pin placement screen. If it accepts an entry, pass the latest one.
            // e.g., PlacePinScreen(trip: trip, entry: trip.journalEntries.last!)
            PlacePinScreen(trip: trip)
        }
    }
}

#Preview {
    let trip = Trip.mock()
    SetUpPinScreen(trip: trip, entry: trip.journalEntries.first!)
        .modelContainer(ModelContainer.preview)
}

