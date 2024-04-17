import UIKit

class AboutAppModuleBuilder: ModuleBuilder {
    typealias ViewController = AboutAppViewController
    typealias ViewModel = MainViewModel

    func build() -> AboutAppViewController {
        let viewController = AboutAppViewController()
        return viewController
    }

    func build(with viewModel: MainViewModel) -> AboutAppViewController {
        let viewController = AboutAppViewController()
        return viewController
    }
}
