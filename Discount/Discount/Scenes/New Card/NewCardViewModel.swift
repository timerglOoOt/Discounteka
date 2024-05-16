import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

class NewCardViewModel {
    let cardService = CardService.shared

    private func configureCard(cardValue: String, cardName: String, cardType: CardType) -> Result<Card, Errors> {
//        guard let cardImage = generateImage(from: cardValue, cardType: cardType) else { return .failure(Errors.imageGenerateFailure) }
//        guard let cardQr = EFQRCode.generate(for: cardValue) else { return  .failure(Errors.imageGenerateFailure) }
        return .success(Card(type: .withQR, name: cardName, code: cardValue))

        // добавить для штрихкода реализацию
    }

    private func generateImage(from string: String, cardType: CardType) -> UIImage? {
        guard let data = string.data(using: .utf8) else { return nil }

            let filterName = (cardType == .withBarcode) ? "CICode128BarcodeGenerator" : "CIQRCodeGenerator"
            guard let filter = CIFilter(name: filterName) else { return nil }

            filter.setValue(data, forKey: "inputMessage")

            let transform = CGAffineTransform(scaleX: 3, y: 3)
            guard let output = filter.outputImage?.transformed(by: transform) else { return nil }

            return UIImage(ciImage: output)
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
