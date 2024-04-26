import Foundation
import EFQRCode

class NewCardViewModel {
    let cardService = CardService.shared

    func configureCard(cardValue: String, cardName: String, cardType: CardType) -> Result<Card, Errors> {
        guard let cardQr = EFQRCode.generate(for: cardValue) else { return  .failure(Errors.imageGenerateFailure) }
        return .success(Card(type: .withQR, name: cardName, code: cardQr))

        //добавить для штрихкода реализацию
    }

    func addNewCard(cardValue: String, cardName: String, cardType: CardType) {
        let confCard = configureCard(cardValue: cardValue, cardName: cardName, cardType: cardType)

        switch confCard {
        case .success(let card):
            cardService.saveCard(card)
        case .failure(let error):
            print("Error on save card \(error)")
        }
    }
}
