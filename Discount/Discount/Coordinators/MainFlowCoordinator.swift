import UIKit

class MainFlowCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainModuleBuilder().build()
        navigationController.pushViewController(mainViewController, animated: true)
    }

    func showAddCardController() {
        print("Add card")
    }

    func showAboutAppController() {
        print("About us")
    }
}
