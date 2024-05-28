import Foundation

protocol SignInOutput: AnyObject {
    func goToSignUpController()
    func signedInUser()
}

final class SignInViewModel {
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
            if curUser != "" {
                UserDefaults.standard.set(curUser, forKey: "curUser")
                await signIn()
            }
            await controller?.view.removeBlurLoader()
        }
    }

    @MainActor
    private func signIn() {
        delegate?.signedInUser()
    }
}
