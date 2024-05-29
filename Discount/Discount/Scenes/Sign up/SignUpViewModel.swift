import Foundation

protocol SignUpOutput: AnyObject {
    func goToSignInController()
    func signedUpUser()
}

protocol SignOutOutput: AnyObject {
    func signedOutUser()
}

final class SignUpViewModel {
    weak var delegate: SignUpOutput?
    weak var controller: SignUpViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func goToSignInController() {
        delegate?.goToSignInController()
    }

    func signUpButtonTapped(user: User, password: String) {
        controller?.view.showBlurLoader()
        Task {
            guard let curUser = await firebase.createUser(user: user, password: password) else {
                await controller?.view.removeBlurLoader()
                return }
            UserDefaults.standard.set(curUser, forKey: "curUser")
            await signUp()
        }
    }

    @MainActor
    private func signUp() {
        delegate?.signedUpUser()
        controller?.view.removeBlurLoader()
    }
}
