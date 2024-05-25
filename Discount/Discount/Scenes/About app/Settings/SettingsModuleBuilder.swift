import Foundation

class SettingsModuleBuilder {
    func build(output: SignOutOutput) -> SettingsViewController {
        let viewModel = SettingsViewModel()
        viewModel.delegate = output
        let controller = SettingsViewController(viewModel: viewModel)
        return controller
    }
}
