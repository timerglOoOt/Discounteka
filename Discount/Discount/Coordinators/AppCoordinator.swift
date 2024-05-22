import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    // TODO: добавить UserDefaults на лог
    var isLogged = false
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
        flowCoordinator = AuthFlowCoordinator(navigationController: navigationController)
        flowCoordinator?.start()
    }
}

extension AppCoordinator: FlowTransitionProtocol {
    func goFromAuthToMainFlow() {
        navigationController.setViewControllers([], animated: false)
        showMainFlow()
    }

    func goFromMainToAuthFlow() {
        //
    }
}
