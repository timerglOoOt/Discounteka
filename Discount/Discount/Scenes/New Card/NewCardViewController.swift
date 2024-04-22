import UIKit

class NewCardViewController: UIViewController {
    private let newCardView = NewCardView(frame: .zero)
    let viewModel: NewCardViewModel

    override func loadView() {
        view = newCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
