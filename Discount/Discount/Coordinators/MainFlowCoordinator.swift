import UIKit

class MainFlowCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainModuleBuilder().build()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }

    func showAddCardController() {
        print("Add card")
    }

    func showAboutAppController() {
        let aboutAppViewController = AboutAppModuleBuilder().build()
        aboutAppViewController.coordinator = self
        navigationController.pushViewController(aboutAppViewController, animated: true)
    }

    func showProfileController() {
        print("profile")
    }

    func showContactUsController() {
        print("contact us")
    }

    func showSettingsController() {
        print("settings")
    }
}
