import Foundation

class SignInModuleBuilder: ModuleBuilder {
    typealias ViewController = SignInViewController

    func build() -> SignInViewController {
        let viewModel = SignInViewModel()
        let controller = SignInViewController(viewModel: viewModel)
        return controller
    }
}
