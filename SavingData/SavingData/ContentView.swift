//
//  ContentView.swift
//  SavingData
//
//  Created by Zachary Jensen on 10/31/25.
//

import SwiftUI

class ContentViewController {
    func getFavoriteMovie() -> String? {
      return  UserDefaults.standard.string(forKey: "FavoriteMovie")
    }
    
    func setFavoriteMovie(_ Movie: String) {
        UserDefaults.standard.set(Movie, forKey: "favoriteMovie")
    }
}

struct ContentView: View {
    
    @AppStorage("favoriteMovie") var favoriteMovie: String = ""
    @State private var favoriteMovie: String = ""
    
    let controller = ContentViewController()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("AppStorage Example")) {
                    TextField("Favorite Color", text: $favoriteMovie)
                        
                    Text("App Storage Value: \(favoriteMovie)")
                }
            }
            .navigationTitle("FileManager & UserDefaults")
        }
    }
}

#Preview {
    ContentView()
}
