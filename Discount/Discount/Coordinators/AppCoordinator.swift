import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var isLogged = true

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
        let mainFlowCoordintor = MainFlowCoordinator(navigationController: navigationController)
        mainFlowCoordintor.start()
    }

    func showAuthFlow() {
        print("Auth flow")
    }
}
