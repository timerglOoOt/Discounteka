import Foundation
import UIKit
import CoreImage.CIFilterBuiltins
import CodeScanner
import AVFoundation

class NewCardViewModel {
    weak var controller: NewCardViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)
    private let cardService = CardService.shared
    private let userId = UserDefaults.standard.string(forKey: "curUser")
    @Published var scannedResult: String?

    private func configureCard(cardValue: String, cardName: String, cardType: AVMetadataObject.ObjectType) -> Card {
        return Card(type: cardType, name: cardName, code: cardValue)
    }

    func addNewCard(cardValue: String, cardName: String, cardType: AVMetadataObject.ObjectType) {
        let confCard = configureCard(cardValue: cardValue, cardName: cardName, cardType: cardType)
        Task {
            await firebase.addCard(toUserId: userId ?? "", card: confCard)
        }
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
