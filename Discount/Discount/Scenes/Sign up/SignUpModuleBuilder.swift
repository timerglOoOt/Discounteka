import Foundation

class SignUpModuleBuilder: ModuleBuilder {
    typealias ViewController = SignUpViewController

    func build() -> SignUpViewController {
        let viewModel = SignUpViewModel()
        let controller = SignUpViewController(viewModel: viewModel)
        return controller
    }
}
