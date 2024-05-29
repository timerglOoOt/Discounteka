import Foundation

final class NewCardChoiseModuleBuilder: ModuleBuilder {
    typealias ViewController = NewCardChoiseViewController

    func build() -> NewCardChoiseViewController {
        let controller = NewCardChoiseViewController()
        return controller
    }
}
