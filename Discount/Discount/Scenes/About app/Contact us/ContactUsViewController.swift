import UIKit

class ContactUsViewController: UIViewController {
    private let viewModel: ContactUsViewModel
    private let contactUsView = ContactUsView(frame: .zero)

    override func loadView() {
        self.view = contactUsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.controller = self
        contactUsView.delegate = self
        setupNavigationBar()
    }

    init(viewModel: ContactUsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ContactUsViewController {
    func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: "Свяжитесь с нами")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension ContactUsViewController: ContactUsViewProtocol {
    func sendButtonTapped(message: String) {
        if contactUsView.checkTextViewIsEmpty() {
            self.showCustomAlert(
                title: "Error",
                message: "You are trying to send an empty message! Please enter the text."
            )
            return
        }
        viewModel.sendMessage(messageText: message)
        handleBackTap()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
