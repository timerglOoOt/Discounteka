import Foundation
import UIKit

protocol AuthFlowCoordinatorOutput: AnyObject {
    func authFlowCoordinatorEnteredUser()
}

class AuthFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var authFlowCoordinatorOutput: AuthFlowCoordinatorOutput?

    init(navigationController: UINavigationController, authFlowCoordinatorOutput: AuthFlowCoordinatorOutput) {
        self.navigationController = navigationController
        self.authFlowCoordinatorOutput = authFlowCoordinatorOutput
    }

    func start() {
        let signUpViewController = SignUpModuleBuilder().build(output: self)
        navigationController.setViewControllers([signUpViewController], animated: true)
    }
}

extension AuthFlowCoordinator: SignInOutput, SignUpOutput {
    func signedInUser() {
        authFlowCoordinatorOutput?.authFlowCoordinatorEnteredUser()
    }

    func signedUpUser() {
        authFlowCoordinatorOutput?.authFlowCoordinatorEnteredUser()
    }

    func goToSignUpController() {
        let signUpViewController = SignUpModuleBuilder().build(output: self)
        navigationController.setViewControllers([signUpViewController], animated: true)

    }

    func goToSignInController() {
        let signInViewController = SignInModuleBuilder().build(output: self)
        navigationController.setViewControllers([signInViewController], animated: true)
    }
}
