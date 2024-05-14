import UIKit

class NewCardViewController: UIViewController {
    private let newCardView = NewCardView(frame: .zero)
    let viewModel: NewCardViewModel

    override func loadView() {
        view = newCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        newCardView.delegate = self
        setupNavigationBar()
    }

    init(viewModel: NewCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewCardViewController {
    private func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: "Карта с QR-кодом")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension NewCardViewController: NewCardSceneDelegate {
    func saveButtonTapped() {
        let cardInfo = newCardView.getTextFields()
        viewModel.addNewCard(cardValue: cardInfo.0, cardName: cardInfo.1, cardType: .withQR)
        navigationController?.popViewController(animated: true)
    }
}
