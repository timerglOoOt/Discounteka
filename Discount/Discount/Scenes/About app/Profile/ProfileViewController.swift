import UIKit

class ProfileViewController: UIViewController {
    private let profileView = ProfileView(frame: .zero)
    private let viewModel: ProfileViewModel

    override func loadView() {
        self.view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        profileView.delegate = self
    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension ProfileViewController {
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

extension ProfileViewController: ProfileViewProtocol {
    func showAlert() {
        self.showCustomAlert(title: "Error", message: "You are trying to send an empty field! Please enter the text.")
    }

    func saveButtonTapped(firstName: String, lastName: String) {
        viewModel.updateUser(firstName: firstName, lastName: lastName)
        handleBackTap()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
