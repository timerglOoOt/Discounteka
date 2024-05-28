import UIKit

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView(frame: .zero)
    private let viewModel: SignUpViewModel

    override func loadView() {
        view = signUpView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.delegate = self
    }

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.controller = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpViewController: SignUpViewProtocol {
    func signUpButtonTapped() {
        guard let pair = signUpView.configureSignUpForm() else {
            self.showAlert(
                title: Strings.error,
                message: Strings.youAreTryingToSendAnEmptyFieldPleaseEnterTheText
            )
            return }
        viewModel.signUpButtonTapped(user: pair.0, password: pair.1)
    }

    func enterLabelTapped() {
        viewModel.goToSignInController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
