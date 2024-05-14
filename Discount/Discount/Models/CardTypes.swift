import Foundation
import UIKit

enum CardType {
    case withBarcode
    case withQR
}

struct Card {
    let type: CardType
    var isClicked: Bool = false
    let name: String
    let code: String
}

extension CardType {
    var isBarcode: Bool {
        switch self {
        case .withBarcode:
            return true

        case .withQR:
            return false
        }
    }
}
