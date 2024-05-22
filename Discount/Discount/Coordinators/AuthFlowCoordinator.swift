import Foundation
import UIKit

class AuthFlowCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signUpViewController = SignUpModuleBuilder().build()
        signUpViewController.delegate = self
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}

extension AuthFlowCoordinator: SignInViewControllerProtocol, SignUpViewControllerProtocol {
    func goToSignUpController() {
        let signUpViewController = SignUpModuleBuilder().build()
        signUpViewController.delegate = self
        navigationController.setViewControllers([signUpViewController], animated: true)

    }

    func goToSignInController() {
        let signInViewController = SignInModuleBuilder().build()
        signInViewController.delegate = self
        navigationController.setViewControllers([signInViewController], animated: true)
    }
}
