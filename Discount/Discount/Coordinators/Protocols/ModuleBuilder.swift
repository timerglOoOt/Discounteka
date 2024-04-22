import UIKit

protocol ModuleBuilder {
    associatedtype ViewController: UIViewController

    func build() -> ViewController
}
