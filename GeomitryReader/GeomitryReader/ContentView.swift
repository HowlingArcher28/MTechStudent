//
//  ContentView.swift
//  GeomitryReader
//
//  Created by Zachary Jensen on 1/6/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.cyan)
                    .containerRelativeFrame(.horizontal) {width, height in width / 2}
                Spacer()
            }
            .background(.red)
            
        } 
        .background(.green)
    }
}

#Preview {
    ContentView()
}
