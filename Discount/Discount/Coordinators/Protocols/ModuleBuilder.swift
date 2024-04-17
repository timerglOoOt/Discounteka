import UIKit

protocol ModuleBuilder {
    associatedtype ViewController: UIViewController
    associatedtype ViewModel

    func build() -> ViewController
    func build(with viewModel: ViewModel) -> ViewController
}
