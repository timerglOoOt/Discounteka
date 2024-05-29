import Foundation

final class NewCardModuleBuilder: ModuleBuilder {
    typealias ViewController = NewCardViewController

    func build() -> NewCardViewController {
        let viewModel = NewCardViewModel()
        let controller = NewCardViewController(viewModel: viewModel)
        return controller
    }
}
