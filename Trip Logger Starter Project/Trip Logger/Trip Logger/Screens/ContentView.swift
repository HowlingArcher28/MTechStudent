//
//  ContentView.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/16/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var trips: [Trip]
        
    @State var isShowingNewTrip = false
    @State private var animateEmpty = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient
                    .ignoresSafeArea()

                Group {
                    if trips.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "map.circle.fill")
                                .font(.system(size: 64))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(Theme.icon)
                                .scaleEffect(animateEmpty ? 1.05 : 0.95)
                                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animateEmpty)

                            Text("No trips yet.")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.secondary)

                            Button {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    isShowingNewTrip = true
                                }
                            } label: {
                                Label("Create Your First Trip", systemImage: "plus.circle.fill")
                                    .font(.headline)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Theme.accent)
                        }
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 8)
                        .onAppear { animateEmpty = true }
                        .transition(.opacity.combined(with: .scale))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding()
                    } else {
                        List {
                            ForEach(trips) { trip in
                                NavigationLink(
                                    destination: TripMapScreen(
                                        trip: trip,
                                        position: .automatic
                                    )
                                ) {
                                    TripRowView(title: trip.name)
                                }
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: Spacing.cardRadius, style: .continuous)
                                        .fill(Theme.rowBackground)
                                        .shadow(color: Theme.rowShadow, radius: 6, x: 0, y: 3)
                                )
                                .contentShape(Rectangle())
                                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                                        removal: .move(edge: .leading).combined(with: .opacity)))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        if let index = trips.firstIndex(where: { $0.id == trip.id }) {
                                            deleteTrips(at: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                            .onDelete(perform: deleteTrips)
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                }
            }
            .navigationTitle("Trip Logger")
            .navigationBarTitleDisplayMode(.large)
            .toolbarTitleMenu {
                Text("Happy travels!")
            }
            .animation(.easeInOut(duration: 0.25), value: trips.count)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            isShowingNewTrip = true
                        }
                    } label: {
                        Label("Add Trip", systemImage: "plus")
                            .foregroundStyle(Color(red: 0.58, green: 0.55, blue: 0.40))
                    }
                }
            }
            .sheet(isPresented: $isShowingNewTrip) {
                NavigationStack {
                    NewTripScreen()
                        .navigationTitle("New Trip")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(LinearGradient(colors: [Color(red: 0.94, green: 0.96, blue: 0.94), Color(red: 0.88, green: 0.90, blue: 0.86)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
                }
                .presentationDetents([.large])
                .presentationCornerRadius(24)
            }
        }
    }
    
    private func deleteTrips(at offsets: IndexSet) {
        for index in offsets {
            let trip = trips[index]
            modelContext.delete(trip)
        }
        do {
            try modelContext.save()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(ModelContainer.preview)
}
