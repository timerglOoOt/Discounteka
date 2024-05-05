import Foundation
import Combine

class CardService {
    @Published var cards: [Card] = []

    public static let shared = CardService()
    private init() {}

    func saveCard(_ card: Card) {
        cards.append(card)
    }

    func removeTask(at index: Int) {
        cards.remove(at: index)
    }

    func getTask(at index: Int) -> Card {
        cards[index]
    }

    func getAllTasks() -> [Card] {
        cards
    }

    func getCount() -> Int {
        cards.count
    }

    func toggleCardVision(at index: Int) {
        cards[index].isClicked.toggle()
    }
}
