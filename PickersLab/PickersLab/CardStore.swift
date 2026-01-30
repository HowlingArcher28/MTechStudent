import Foundation
import Combine
import SwiftUI

final class CardStore: ObservableObject {
    @Published var cards: [Card] = []

    init(cards: [Card] = []) {
        self.cards = cards
    }

    func add(_ card: Card) {
        cards.append(card)
    }

    func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}
