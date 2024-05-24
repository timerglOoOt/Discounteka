import Foundation

protocol SignInOutput: AnyObject {
    func goToSignUpController()
    func signedInUser()
}

class SignInViewModel {
    weak var delegate: SignInOutput?
    weak var controller: SignInViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func goToSignUpController() {
        delegate?.goToSignUpController()
    }

    func signInButtonTapped(email: String?, password: String?) {
        controller?.view.showBlurLoader()
        Task {
            let curUser = await firebase.signInUser(email: email, password: password)
            UserDefaults.standard.set(curUser, forKey: "curUser")
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.signedInUser()
                self?.controller?.view.removeBlurLoader()
            }
        }
    }
}
