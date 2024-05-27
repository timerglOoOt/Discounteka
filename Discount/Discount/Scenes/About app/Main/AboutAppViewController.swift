import UIKit

protocol AboutAppControllerDelegate: AnyObject {
    func showScreenByTag(_ tag: Int)
}

class AboutAppViewController: UIViewController {
    private let aboutAppView = AboutAppView(frame: .zero)
    weak var delegate: AboutAppControllerDelegate?

    override func loadView() {
        view = aboutAppView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupGestures()
    }
}

extension AboutAppViewController {
    private func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: "About app".localized())

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }

    private func setupGestures() {
        aboutAppView.labelTappedClosure = { [weak self] tag in
            self?.delegate?.showScreenByTag(tag)
        }
    }
}
