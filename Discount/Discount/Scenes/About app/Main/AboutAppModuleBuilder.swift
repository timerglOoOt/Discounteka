import UIKit

final class AboutAppModuleBuilder: ModuleBuilder {
    typealias ViewController = AboutAppViewController

    func build() -> AboutAppViewController {
        let viewController = AboutAppViewController()
        return viewController
    }
}
