import Foundation

class SettingsModuleBuilder: ModuleBuilder {
    typealias ViewController = SettingsViewController

    func build() -> SettingsViewController {
        let viewModel = SettingsViewModel()
        let controller = SettingsViewController(viewModel: viewModel)
        return controller
    }
}
