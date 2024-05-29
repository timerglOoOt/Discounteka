import XCTest
@testable import Discount

class MockCardService: CardServiceProtocol {
    var cards: [Card] = []

    func getCount() -> Int {
        return cards.count
    }

    func getCard(at index: Int) -> Card {
        return cards[index]
    }

    func toggleCardVision(at index: Int) {
        cards[index].isClicked.toggle()
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
    }

    func saveCard(_ card: Discount.Card) {
        cards.append(card)
    }

    func cleanCards() {
        cards = []
    }
}

class MockMainViewOutput: MainViewOutput {
    var didShowAboutAppController = false
    var didShowNewCardController = false

    func showAboutAppController() {
        didShowAboutAppController = true
    }

    func showNewCardController() {
        didShowNewCardController = true
    }
}
