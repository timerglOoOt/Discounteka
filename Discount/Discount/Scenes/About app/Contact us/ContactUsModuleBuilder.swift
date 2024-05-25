import Foundation

class ContactUsModuleBuilder: ModuleBuilder {
    typealias ViewController = ContactUsViewController

    func build() -> ContactUsViewController {
        let viewModel = ContactUsViewModel()
        let controller = ContactUsViewController(viewModel: viewModel)
        return controller
    }
}
