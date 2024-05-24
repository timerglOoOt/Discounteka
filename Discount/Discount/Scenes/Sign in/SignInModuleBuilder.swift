import Foundation

class SignInModuleBuilder {
    func build(output: SignInOutput) -> SignInViewController {
        let viewModel = SignInViewModel()
        viewModel.delegate = output
        let controller = SignInViewController(viewModel: viewModel)
        return controller
    }
}
