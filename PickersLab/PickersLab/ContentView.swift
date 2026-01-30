import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: CardStore
    @State private var currentCard = Card()

    var body: some View {
        TabView {
            CardCreateView()
                .tabItem {
                    Label("Create", systemImage: "square.and.pencil")
                }

            NavigationStack {
                List {
                    if store.cards.isEmpty {
                        ContentUnavailableView("No Cards Yet", systemImage: "tray", description: Text("Create a card to see it here."))
                        
                    } else {
                        ForEach(store.cards.indices, id: \.self) { index in
                            let card = store.cards[index]
                            NavigationLink(value: index) {
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(card.backgroundColor)
                                        .frame(width: 16, height: 16)

                                    VStack(alignment: .leading) {
                                        Text(card.description.isEmpty ? "Untitled Card" : card.description)
                                            .lineLimit(1)
                                        Text(card.date.formatted(date: .abbreviated, time: .shortened))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    if let data = card.imageData, let ui = UIImage(data: data) {
                                        Image(uiImage: ui)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                    }
                                }
                            }
                        }
                        .onDelete(perform: store.remove)
                    }
                }
                .navigationDestination(for: Int.self) { index in
                    CardPreviewView(card: store.cards[index])
                }
                .navigationTitle("Cards")
                .toolbar { EditButton() }
            }
            .tabItem {
                Label("Cards", systemImage: "rectangle.stack")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CardStore())
}
