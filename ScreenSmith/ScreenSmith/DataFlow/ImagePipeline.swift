//
//  ImagePipeline.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import UIKit
import SwiftUI
import Combine

struct ImagePipelineView: View {
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            TextField("Enter your name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
