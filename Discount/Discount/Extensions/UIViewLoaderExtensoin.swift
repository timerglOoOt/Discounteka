import UIKit

extension UIView {
    func showBlurLoader() {
        let blurLoader = UIBlurLoader(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is UIBlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}
