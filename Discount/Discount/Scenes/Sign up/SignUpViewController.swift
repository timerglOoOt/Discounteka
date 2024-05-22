import UIKit

protocol SignUpViewControllerProtocol: AnyObject {
    func goToSignInController()
}

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView(frame: .zero)
    private let viewModel: SignUpViewModel
    weak var delegate: SignUpViewControllerProtocol?
    weak var flowDelegate: FlowTransitionProtocol?
    private var firebase: FirebaseManager?

    override func loadView() {
        view = signUpView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.delegate = self
        firebase = FirebaseManager(viewController: self)
    }

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpViewController: SignUpViewProtocol {
    func enterLabelTapped() {
        delegate?.goToSignInController()
    }

    func signUpButtonTapped() {
        let pair = signUpView.configureSignUpForm()
        Task {
            await firebase?.createUser(user: pair.0, password: pair.1)
            flowDelegate?.goFromAuthToMainFlow()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
