import Foundation

protocol SignUpOutput: AnyObject {
    func goToSignInController()
    func signedUpUser()
}

protocol SignOutOutput: AnyObject {
    func signedOutUser()
}

class SignUpViewModel {
    weak var delegate: SignUpOutput?
    weak var controller: SignUpViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func goToSignInController() {
        delegate?.goToSignInController()
    }

    func signUpButtonTapped(user: User, password: String) {
        controller?.view.showBlurLoader()
        Task {
            let curUser = await firebase.createUser(user: user, password: password)
            UserDefaults.standard.set(curUser, forKey: "curUser")
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.signedUpUser()
                self?.controller?.view.removeBluerLoader()
            }
        }
    }
}
