import UIKit

protocol NewCardChoiseControllerDelegate: AnyObject {
    func showNewCardScreenByTag(_ tag: Int)
}

class NewCardChoiseViewController: UIViewController {
    private let newCardChoiseView = NewCardChoiseView(frame: .zero)
    weak var delegate: NewCardChoiseControllerDelegate?

    override func loadView() {
        view = newCardChoiseView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupGestures()
    }
}

extension NewCardChoiseViewController {
    private func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: Strings.newCard)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }

    private func setupGestures() {
        newCardChoiseView.labelTappedClosure = { [weak self] tag in
            self?.delegate?.showNewCardScreenByTag(tag)
        }
    }
}
