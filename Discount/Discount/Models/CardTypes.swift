import Foundation
import UIKit

enum CardType {
    case withBarcode
    case withQR
}

protocol Type {
    var type: CardType { get }
    var isClicked: Bool { get set }
}

struct CardWithBarcode: Type {
    var type: CardType = .withBarcode
    var isClicked: Bool = false
    let name: String
    let barcode: UIImageView
}

struct CardWithQR: Type {
    var type: CardType = .withQR
    var isClicked: Bool = false
    let name: String
    let qrcode: UIImageView
}
