import UIKit

// MARK: Обычный кастомный label, в котором сразу можно задать выравнивание

final class UICustomLabel: UILabel {
    init(labelText: String, alignment: NSTextAlignment) {
        super.init(frame: .zero)

        configureLabel(labelText: labelText, alignment: alignment)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UICustomLabel {
    func configureLabel(labelText: String, alignment: NSTextAlignment) {
        text = labelText
        numberOfLines = .zero
        font = .systemFont(ofSize: 24, weight: .bold)
        textColor = UIColor(named: "textColor")
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
    }
}
