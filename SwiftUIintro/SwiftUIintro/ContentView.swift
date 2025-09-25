//
//  ContentView.swift
//  SwiftUIintro
//
//  Created by Zachary Jensen on 9/23/25.
//

import SwiftUI
struct ContentView: View {
    let string = "Jeff"
    var body: some View {
        Text("Im one minute old today,")
            .font(.custom("Party LET", size: 70))
        Text("and everything is going great,")
            .font(.custom("Party LET", size: 70))
        Text("I hope it stays that way!")
            .font(.custom("Party LET", size: 70))
        Text("🌝")
            .font(.custom("Party LET", size: 70))
        
        Text(string)
            .bold()
            .italic()
            .font(.custom("Party LET", size: 70))
//            .onAppear() {
//                print(UIFont.familyNames)
//            }
        
    }
}



    
#Preview {
    ContentView()
}
