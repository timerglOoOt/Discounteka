import UIKit

class MainModuleBuilder: ModuleBuilder {
    typealias ViewController = MainViewController

    func build() -> MainViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
