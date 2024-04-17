import UIKit

class MainModuleBuilder: ModuleBuilder {
    typealias ViewController = MainViewController
    typealias ViewModel = MainViewModel

    func build() -> MainViewController {
        let viewModel = MainViewModel()
        let coordinator = MainFlowCoordinator(navigationController: UINavigationController())
        let viewController = MainViewController(viewModel: viewModel)
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        return viewController
    }

    func build(with viewModel: MainViewModel) -> MainViewController {
        let coordinator = MainFlowCoordinator(navigationController: UINavigationController())
        let viewController = MainViewController(viewModel: viewModel)
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        return viewController
    }
}
