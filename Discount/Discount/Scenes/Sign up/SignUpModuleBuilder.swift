import Foundation

final class SignUpModuleBuilder {
    func build(output: SignUpOutput) -> SignUpViewController {
        let viewModel = SignUpViewModel()
        viewModel.delegate = output
        let controller = SignUpViewController(viewModel: viewModel)
        return controller
    }
}
