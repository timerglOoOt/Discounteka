import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var isLogged = true
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

extension AppCoordinator {
    func showMainFlow() {
        flowCoordinator = MainFlowCoordinator(navigationController: navigationController)
        flowCoordinator?.start()
    }

    func showAuthFlow() {
        print("Auth flow")
    }
}
