import UIKit

class AboutAppViewController: UIViewController {
    private let aboutAppView = AboutAppView(frame: .zero)
    var coordinator: MainFlowCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view = aboutAppView
        setupNavigationBar()
        setupGestures()
    }
}

extension AboutAppViewController {
    private func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: "О приложении")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }

    private func setupGestures() {
        aboutAppView.labelTappedClosure = { [weak self] tag in
            switch tag {
            case 1:
                self?.coordinator?.showProfileController()
            case 2:
                self?.coordinator?.showSettingsController()
            case 3:
                self?.coordinator?.showContactUsController()
            default:
                break
            }
        }
    }
}
