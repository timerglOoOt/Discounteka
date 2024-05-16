import Foundation
import Combine

class CardService {
    @Published var cards: [Card] = []

    public static let shared = CardService()
    private init() {}
    private let lock = NSLock()

    func saveCard(_ card: Card) {
        lock.lock()
        cards.append(card)
        lock.unlock()
    }

    func removeCard(at index: Int) {
        lock.lock()
        cards.remove(at: index)
        lock.unlock()
    }

    func getCard(at index: Int) -> Card {
        cards[index]
    }

    func getAllCards() -> [Card] {
        cards
    }

    func getCount() -> Int {
        cards.count
    }

    func toggleCardVision(at index: Int) {
        cards[index].isClicked.toggle()
    }
}
