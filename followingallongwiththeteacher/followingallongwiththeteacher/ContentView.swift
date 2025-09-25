//
//  ContentView.swift
//  followingallongwiththeteacher
//
//  Created by Zachary Jensen on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(10))
        }
    }
}

#Preview {
    ContentView()
}
