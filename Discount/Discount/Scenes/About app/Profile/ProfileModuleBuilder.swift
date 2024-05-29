import Foundation

final class ProfileModuleBuilder {
    func build() -> ProfileViewController {
        let viewModel = ProfileViewModel()
        let controller = ProfileViewController(viewModel: viewModel)
        return controller
    }
}
