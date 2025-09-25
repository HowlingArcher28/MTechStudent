//
//  ContentView.swift
//  View Modifiers Lab
//
//  Created by Zachary Jensen on 9/25/25.
//

import SwiftUI

// MARK: - Custom View Modifier

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .italic()
            .underline(color: Color.yellow)
            .strikethrough()
            .border(Color.red, width: 1)
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(20)
    }
}

extension View {
    func myModifier() -> some View {
        self.modifier(MyModifier())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .myModifier()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
