import Foundation

class NewCardChoiseModuleBuilder: ModuleBuilder {
    typealias ViewController = NewCardChoiseViewController

    func build() -> NewCardChoiseViewController {
        let controller = NewCardChoiseViewController()
        return controller
    }
}
