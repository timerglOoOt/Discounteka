import UIKit

class SignInViewController: UIViewController {
    private let signInView = SignInView(frame: .zero)
    private let viewModel: SignInViewModel

    override func loadView() {
        view = signInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signInView.delegate = self
    }

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.controller = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInViewController: SignInViewProtocol {
    func signUpLabelTapped() {
        viewModel.goToSignUpController()
    }

    func signInButtonTapped() {
        let form = signInView.configureSignInForm()
        viewModel.signInButtonTapped(email: form.0, password: form.1)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
