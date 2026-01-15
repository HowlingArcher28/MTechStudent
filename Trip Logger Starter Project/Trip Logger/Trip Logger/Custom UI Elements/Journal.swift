//
//  Journal.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct Journal: View {
    @Binding var journalEntry: JournalEntry?
    
    var body: some View {
        JournalTopBar(journalEntry: $journalEntry)
            .padding()
        
        if let journalEntry {
            VStack(alignment: .leading, spacing: 8) {
                Text(journalEntry.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                if !journalEntry.text.isEmpty {
                    Text(journalEntry.text)
                        .font(.body)
                }
                
                PhotoScrollView(journalEntry: journalEntry)
            }
            .padding(.horizontal)
        }
    }
}

struct JournalTopBar: View {
    @Binding var journalEntry: JournalEntry?
    @State private var showingPopup = false
    @Environment(\.modelContext) private var modelContext
    @State private var saveError: Error?
    @State private var showSaveError = false
    
    var body: some View {
        HStack {
            Button("Edit") {
                showingPopup = true
            }
            
            Spacer()
            
            Text(journalEntry?.name ?? "Journal")
                .font(.title)
                .lineLimit(1)
            
            Spacer()
            
            Button("Dismiss") {
                journalEntry = nil
            }
        }
        .popover(isPresented: $showingPopup) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Edit Journal Entry")
                    .font(.headline)
                
                if let _ = journalEntry {
                    TextField("Name", text: Binding(
                        get: { journalEntry?.name ?? "" },
                        set: { journalEntry?.name = $0 }
                    ))
                    .textFieldStyle(.roundedBorder)
                    
                    TextField("Notes", text: Binding(
                        get: { journalEntry?.text ?? "" },
                        set: { journalEntry?.text = $0 }
                    ), axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
                    
                    if let entry = journalEntry {
                        PhotoScrollView(journalEntry: entry)
                    }
                    
                    HStack {
                        Spacer()
                        Button("Save Changes") {
                            do {
                                try modelContext.save()
                                showingPopup = false
                            } catch {
                                saveError = error
                                showSaveError = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    Text("No entry selected.")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Spacer()
                    Button("Close") {
                        showingPopup = false
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .frame(minWidth: 300, minHeight: 300)
        }
        .alert("Save Failed", isPresented: $showSaveError, presenting: saveError) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    @Previewable @State var trip = Trip.mock()
    
    TripMapScreen(trip: trip, position: .automatic, selectedEntry: trip.journalEntries.first)
}

