import UIKit

protocol SignInViewControllerProtocol: AnyObject {
    func goToSignUpController()
}

protocol FlowTransitionProtocol: AnyObject {
    func goFromAuthToMainFlow()
    func goFromMainToAuthFlow()
}

class SignInViewController: UIViewController {
    private let signInView = SignInView(frame: .zero)
    private let viewModel: SignInViewModel
    weak var delegate: SignInViewControllerProtocol?
    weak var flowDelegate: FlowTransitionProtocol?
    private var firebase: FirebaseManager?

    override func loadView() {
        view = signInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signInView.delegate = self
        firebase = FirebaseManager(viewController: self)
    }

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInViewController: SignInViewProtocol {
    func signUpLabelTapped() {
        delegate?.goToSignUpController()
    }

    func signInButtonTapped() {
        Task {
            let form = signInView.configureSignInForm()
            await firebase?.signInUser(email: form.0, password: form.1)
            flowDelegate?.goFromAuthToMainFlow()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
