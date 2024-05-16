import Foundation
import UIKit
import CoreImage.CIFilterBuiltins
import CodeScanner

class NewCardViewModel {
    let cardService = CardService.shared
    @Published var scannedResult: String?

    private func configureCard(cardValue: String, cardName: String, cardType: CardType) -> Card {
        return Card(type: cardType, name: cardName, code: cardValue)
    }

    func addNewCard(cardValue: String, cardName: String, cardType: CardType) {
        let confCard = configureCard(cardValue: cardValue, cardName: cardName, cardType: cardType)

        cardService.saveCard(confCard)
    }

    func scanCard(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            DispatchQueue.main.async {
                self.scannedResult = result.string
            }
            print("Found code: \(result.string)")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
