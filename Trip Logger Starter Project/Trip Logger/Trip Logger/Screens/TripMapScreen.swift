//
//  TripMapScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct TripMapScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var trip: Trip
    
    @State var position: MapCameraPosition
    @State var selectedEntry: JournalEntry?
    
    @State private var isRenaming = false
    @State private var draftName: String = ""
    @State private var isAddingPin = false
    @State private var showDeleteConfirm = false
    @State private var saveError: Error?
    @State private var showSaveError = false
    
    var body: some View {
        VStack {
            MapReader { reader in
                Map(position: $position, interactionModes: .all) {
                    mapAnnotations
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            guard isAddingPin else { return }
                            let location = value.location
                            if let coordinate = reader.convert(location, from: .local) {
                                addEntry(at: coordinate)
                            }
                        }
                )
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(trip.journalEntries), id: \.id) { entry in
                        HStack(spacing: 6) {
                            Text(entry.name).lineLimit(1)
                            Button(role: .destructive) {
                                if let idx = trip.journalEntries.firstIndex(where: { $0.id == entry.id }) {
                                    let removed = trip.journalEntries.remove(at: idx)
                                    modelContext.delete(removed)
                                    do { try modelContext.save() } catch { saveError = error; showSaveError = true }
                                    if selectedEntry?.id == entry.id { selectedEntry = nil }
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.secondarySystemBackground)))
                        .onTapGesture { selectedEntry = entry }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 8)
            
            if selectedEntry != nil {
                Journal(journalEntry: $selectedEntry)
            }
            
        }
        .navigationTitle(trip.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(isAddingPin ? "Done Adding Pins" : "Add Pin") {
                    isAddingPin.toggle()
                }
                Menu("Edit") {
                    Button("Rename") {
                        draftName = trip.name
                        isRenaming = true
                    }
                    Button("Delete Trip", role: .destructive) {
                        showDeleteConfirm = true
                    }
                    Button("Delete Selected Pin", role: .destructive) {
                        if let entry = selectedEntry {
                            if let index = trip.journalEntries.firstIndex(where: { $0.id == entry.id }) {
                                let removed = trip.journalEntries.remove(at: index)
                                modelContext.delete(removed)
                                do { try modelContext.save() } catch { saveError = error; showSaveError = true }
                                selectedEntry = nil
                            }
                        }
                    }
                    .disabled(selectedEntry == nil)
                }
            }
        }
        .sheet(isPresented: $isRenaming) {
            NavigationStack {
                Form {
                    TextField("Trip name", text: $draftName)
                }
                .navigationTitle("Rename Trip")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { isRenaming = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            trip.name = draftName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? trip.name : draftName
                            do {
                                try modelContext.save()
                                isRenaming = false
                            } catch {
                                saveError = error
                                showSaveError = true
                            }
                        }
                    }
                }
            }
            .presentationDetents([.fraction(0.35)])
        }
        .alert("Delete Trip?", isPresented: $showDeleteConfirm) {
            Button("Delete", role: .destructive) {
                modelContext.delete(trip)
                do {
                    try modelContext.save()
                    dismiss()
                } catch {
                    saveError = error
                    showSaveError = true
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will remove the trip and all associated entries.")
        }
        .alert("Save Failed", isPresented: $showSaveError, presenting: saveError) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
    
    private var mapAnnotations: some MapContent {
        ForEach(Array(trip.journalEntries), id: \.id) { journalEntry in
            if let coordinate = journalEntry.location.coordinate {
                Annotation(journalEntry.name, coordinate: coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .shadow(radius: 2)
                        .onTapGesture { selectedEntry = journalEntry }
                }
            }
        }
    }
    
    private func addEntry(at coordinate: CLLocationCoordinate2D) {
        let loc = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let entry = JournalEntry(name: "New Stop", location: loc)
        entry.trip = trip
        trip.journalEntries.append(entry)
        selectedEntry = entry
        position = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
        do {
            try modelContext.save()
        } catch {
            saveError = error
            showSaveError = true
        }
    }
}

#Preview {
    NavigationStack {
        TripMapScreen(trip: Trip.mock(), position: .automatic)
            .modelContainer(ModelContainer.preview)
    }
}

