//
//  ContentView.swift
//  UI Elements
//
//  Created by Zachary Jensen on 9/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    @State private var textfieldText = ""
    @State private var securefieldText = ""
    @State private var sliderValue = 0.0
    @State private var pickerValue = "Option 1"
    
    var body: some View {
        VStack(spacing: 30) {
            Toggle("This is a toggle", isOn: $isOn)
            Toggle(isOn: $isOn) {
                Text("This is also a toggle")
            }
            .tint(Color.red)
            
            TextField("This is a text field", text: $textfieldText, prompt: Text("This is a prompt").font(.custom("Zapfino", size: 18)), axis: .horizontal)
                .textFieldStyle(.roundedBorder)
            
            SecureField("This is a secure field", text: $securefieldText)
                .textFieldStyle(.roundedBorder)
            
            VStack {
                Text("this slider value is \(sliderValue)")
                Slider(value: $sliderValue)
                
                Slider(value: $sliderValue, in: 0...10, step: 1) {
                    editing in print("Is editing slider\(editing)")
                }
            }
            
            Picker("My picker", selection: $pickerValue) {
                ForEach(["option 1", "option 2", "option 3"], id: \.self) {
                    item in
                    
                    Text(item)
                        .tag(item)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
