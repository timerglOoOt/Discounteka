import UIKit

class MainModuleBuilder: ModuleBuilder {
    typealias ViewController = MainViewController
    typealias ViewModel = MainViewModel

    func build() -> MainViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        viewController.viewModel = viewModel
        return viewController
    }

    func build(with viewModel: MainViewModel) -> MainViewController {
        let viewController = MainViewController(viewModel: viewModel)
        viewController.viewModel = viewModel
        return viewController
    }
}
