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
    let code: UIImageView
}
