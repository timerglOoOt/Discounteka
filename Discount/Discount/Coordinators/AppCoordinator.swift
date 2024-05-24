import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var isLogged = UserDefaults.standard.string(forKey: "curUser") != ""
    var flowCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isLogged {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }
}

private extension AppCoordinator {
    func showMainFlow() {
        flowCoordinator = MainFlowCoordinator(navigationController: navigationController)
        flowCoordinator?.start()
    }

    func showAuthFlow() {
        flowCoordinator = AuthFlowCoordinator(navigationController: navigationController, authFlowCoordinatorOutput: self)
        flowCoordinator?.start()
    }
}

extension AppCoordinator: AuthFlowCoordinatorOutput {
    func authFlowCoordinatorEnteredUser() {
        showMainFlow()
    }
}
