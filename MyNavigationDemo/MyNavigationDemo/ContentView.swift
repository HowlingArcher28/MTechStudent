//
//  ContentView.swift
//  MyNavigationDemo
//
//  Created by Zachary Jensen on 10/8/25.
//

import SwiftUI


struct Student: Identifiable {
    var id: UUID = UUID()
    var name: String
    var favoriteColor: Color
}

let students = [
    Student(name: "Alice ", favoriteColor: .red),
    Student(name: "Bob", favoriteColor: .blue),
    Student(name: "Charlie", favoriteColor: .green),
    Student(name: "Diana", favoriteColor: .purple),
    Student(name: "Ethan", favoriteColor: .orange),
    Student(name: "Fiona", favoriteColor: .pink),
    Student(name: "George", favoriteColor: .teal),
    Student(name: "Hannah", favoriteColor: .mint),
    Student(name: "Ian", favoriteColor: .indigo),
    Student(name: "Jasmine", favoriteColor: .yellow),
    Student(name: "Kevin", favoriteColor: .brown),
    Student(name: "Luna", favoriteColor: .cyan)
]

struct ContentView: View {
    @State private var isPresentingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Present Sheet") {
                    isPresentingSheet = true
                }
                
                List(students) { student in
                    NavigationLink {
                        student.favoriteColor
                            .ignoresSafeArea()
                    } label: {
                        Text(student.name)
                    }
                }
                .navigationTitle("Students")
            }
            .sheet(isPresented: $isPresentingSheet) {
                Text("Sheet happens")
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
