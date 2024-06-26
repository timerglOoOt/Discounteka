import Foundation
import Combine

protocol CardServiceProtocol: AnyObject {
    func saveCard(_ card: Card)
    func removeCard(at index: Int)
    func getCard(at index: Int) -> Card
    func getCount() -> Int
    func toggleCardVision(at index: Int)
    func cleanCards()
}

class CardService: CardServiceProtocol {
    private let firebase = FirebaseManager(alertShowable: nil)
    @Published var cards: [Card] = []
    public static let shared = CardService()
    private let lock = NSLock()

    private init() {}

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

    func getCards() {
        let userId = UserDefaults.standard.string(forKey: "curUser")
        Task {
            guard let userId = userId else { return }
            cards = await firebase.getCards(forUserId: userId) ?? []
        }
    }

    func cleanCards() {
        cards = []
    }
}
