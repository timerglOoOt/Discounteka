import Foundation

protocol SignUpOutput: AnyObject {
    func goToSignInController()
    func signedUpUser()
}

class SignUpViewModel {
    weak var delegate: SignUpOutput?
    weak var controller: SignUpViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func goToSignInController() {
        delegate?.goToSignInController()
    }

    func signUpButtonTapped(user: User, password: String) {
        Task {
            DispatchQueue.main.async { [weak self] in
                self?.controller?.view.showBlurLoader()
            }
            await firebase.createUser(user: user, password: password)
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.signedUpUser()
                self?.controller?.view.removeBluerLoader()
            }
        }
    }
}
