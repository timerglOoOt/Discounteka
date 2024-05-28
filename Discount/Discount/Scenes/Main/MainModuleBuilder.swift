import UIKit

final class MainModuleBuilder {
    func build(output: MainViewOutput) -> MainViewController {
        let viewModel = MainViewModel()
        viewModel.delegate = output
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
