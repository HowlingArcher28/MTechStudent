import Foundation
import SwiftUI
import Combine

final class QuoteStore: ObservableObject {
    @Published var quotes: [Quote]

    init(quotes: [Quote] = [
        Quote(text: "Life is like a path you walk through a flowering field, backwards. You only see the beauty after you pass it.", author: "Unknown"),
        Quote(text: "You were given life because you are strong enough to live it.", author: "Unknown"),
        Quote(text: "Don’t count the days, make the days count.", author: "Muhammad Ali"),
        Quote(text: "Whether you think you can, or you think you can’t—you’re right.", author: "Henry Ford"),
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
        Quote(text: "It always seems impossible until it’s done.", author: "Nelson Mandela"),
        Quote(text: "Simplicity is the ultimate sophistication.", author: "Leonardo da Vinci"),
        Quote(text: "The best way to predict the future is to invent it.", author: "Alan Kay")
    ]) {
        self.quotes = quotes
    }

    func add(text: String, author: String) {
        let new = Quote(text: text, author: author)
        quotes.insert(new, at: 0)
    }

    func delete(at offsets: IndexSet) {
        quotes.remove(atOffsets: offsets)
    }
}
