//
//  ContentView.swift
//  Lazy Grids
//
//  Created by Zachary Jensen on 1/30/26.
//

import SwiftUI

struct ContentView: View {
    var hats: [(name: String, price: Double)] { SampleData.hats }
    var shirts: [(name: String, price: Double)] { SampleData.shirts }
    var pants: [(name: String, price: Double)] { SampleData.pants }

    var body: some View {
        ScrollView {
           
            VStack(alignment: .leading, spacing: 24) {
    
                Text("Hats")
                    .font(.title2).bold()
                    .padding(.horizontal)

                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.fixed(120), spacing: 4)], spacing: 4) {
                        ForEach(hats, id: \.name) { item in
                            ProductCard(title: item.name, price: item.price, color: .orange)
                                .frame(width: 130, height: 120)
                                .scrollTargetLayout()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)

                Text("Shirts")
                    .font(.title2).bold()
                    .padding(.horizontal)

                ScrollView(.horizontal) {
                    LazyHGrid(rows: [
                        GridItem(.fixed(120), spacing: 8),
                        GridItem(.fixed(120), spacing: 8)
                    ], spacing: 8) {
                        ForEach(shirts, id: \.name) { item in
                            ProductCard(title: item.name, price: item.price, color: .blue)
                                .frame(width: 160, height: 120)
                                .scrollTargetLayout()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                Text("Pants")
                    .font(.title2).bold()
                    .padding(.horizontal)

                ScrollView(.horizontal) {
                   
                    LazyHGrid(rows: [
                        GridItem(.fixed(116), spacing: 8),
                        GridItem(.fixed(116), spacing: 8),
                        GridItem(.fixed(116), spacing: 8),
                        GridItem(.fixed(116), spacing: 8)
                    ], spacing: 8) {
                        ForEach(pants, id: \.name) { item in
                            ProductCard(title: item.name, price: item.price, color: .green)
                                .frame(width: 120, height: 116)
                                .scrollTargetLayout()
                        }
                    }
                }
                .frame(height: 4 * 116 + 3 * 8)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    ContentView()
}
