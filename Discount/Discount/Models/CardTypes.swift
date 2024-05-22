import Foundation
import UIKit
import AVFoundation

enum CardType {
    case withBarcode
    case withQR
}

enum BarcodeType {
    case ean13, upce, code128, code39, code93, code39Mod43, interleaved2of5
}

struct Card {
    let type: AVMetadataObject.ObjectType
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
