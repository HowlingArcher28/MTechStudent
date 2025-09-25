import SwiftUI

struct ContentView: View {
    // Friends list
    let friendsList = ["Shrek", "Donkey", "Fiona", "Knight 1", "Knight 2", "Knight 3.45"]
    // MARK: - badges/titles earned
    let badges = [
        ("Ogre Slayer", Color.green),
        ("Castle Conqueror", Color.purple),
        ("Onion Enthusiast", Color.orange),
        ("Quest Master", Color.blue)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.1))
                .padding()
            
            VStack {
                VStack(spacing: 24) {
                    // MARK: - Profile Image Placeholder
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        )
                        .padding(.top, 32)
                    
                    // MARK: - Name and Username
                    VStack(spacing: 4) {
                        Text("Lord FarkWad")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("@JefftheMan")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: - Info Card
                    VStack(alignment: .leading, spacing: 16) {
                        // Info Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Info")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Professional Ogre Killer. Likes onions and castles. Available for quests. A little short.")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        
                        Divider().background(Color.white.opacity(0.3))
                        
                        // MARK: - Friends List
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Friends")
                                .font(.headline)
                                .foregroundColor(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(friendsList, id: \.self) { friend in
                                        HStack(spacing: 6) {
                                            Circle()
                                                .fill(Color.gray.opacity(0.6))
                                                .frame(width: 28, height: 28)
                                                .overlay(
                                                    Image(systemName: "person.fill")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.white.opacity(0.8))
                                                )
                                            Text(friend)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(Color.white.opacity(0.08))
                                        .clipShape(Capsule())
                                            
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.08))
                    )
                    .padding(.horizontal)
                    
                    // MARK: - Badges
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Badges")
                            .font(.headline)
                            .foregroundColor(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(badges, id: \.0) { badge in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(badge.1.opacity(0.3))
                                            .frame(width: 150, height: 60)
                                        HStack {
                                            Image(systemName: "trophy.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(badge.1)
                                            Text(badge.0)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ContentView()
}
