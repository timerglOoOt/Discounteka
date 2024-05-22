import UIKit

// MARK: Логика старта главного потока приложения

class MainFlowCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainModuleBuilder().build()
        mainViewController.delegate = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}

// MARK: Настройка для экрана "О Нас"

extension MainFlowCoordinator: AboutAppControllerDelegate {
    func showScreenByTag(_ tag: Int) {
        switch tag {
        case 1:
            showProfileController()
        case 2:
            showSettingsController()
        case 3:
            showContactUsController()
        default:
            break
        }
    }

    private func showProfileController() {
        print("profile")
    }

    private func showContactUsController() {
        print("contact us")
    }

    private func showSettingsController() {
        print("settings")
    }
}

// MARK: Настройка для экрана добавления карты

extension MainFlowCoordinator: NewCardChoiseControllerDelegate {
    func showNewCardScreenByTag(_ tag: Int) {
        let newCardViewController = NewCardModuleBuilder().build()
        switch tag {
        case 1:
            newCardViewController.cardType = .qr
        case 2:
            newCardViewController.cardType = .code128
        default:
            break
        }
        navigationController.pushViewController(newCardViewController, animated: true)
    }

//    private func showNewQRCardController() {
//        let newCardViewController = NewCardModuleBuilder().build()
//        newCardViewController.cardType = .withQR
//        navigationController.pushViewController(newCardViewController, animated: true)
//    }
//
//    private func showNewBarcodeCardController() {
//        print("contact us")
//    }
}
// MARK: Настройка для главного экрана

extension MainFlowCoordinator: MainViewControllerDelegate {
    func showNewCardController() {
        let newCardChoiseViewController = NewCardChoiseModuleBuilder().build()
        newCardChoiseViewController.delegate = self
        navigationController.pushViewController(newCardChoiseViewController, animated: true)
    }

    func showAboutAppController() {
        let aboutAppViewController = AboutAppModuleBuilder().build()
        aboutAppViewController.delegate = self
        navigationController.pushViewController(aboutAppViewController, animated: true)
    }
}
