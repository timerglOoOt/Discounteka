import Foundation
import UIKit

extension UIViewController: AlertShowable {
    func showCustomAlert(title: String, message: String) async {
        self.showAlert(title: title, message: message)
    }
}
