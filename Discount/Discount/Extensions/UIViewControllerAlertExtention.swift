import Foundation
import UIKit

extension UIViewController: AlertShowable {
    func showCustomAlertAsync(title: String, message: String) async {
        self.showAlert(title: title, message: message)
    }

    func showCustomAlert(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}
