import UIKit

// MARK: Обычный кастомный label, в котором сразу можно задать выравнивание

class UICustomLabel: UILabel {
    init(labelText: String, alignment: NSTextAlignment) {
        super.init(frame: .zero)

        text = labelText
        numberOfLines = .zero
        font = .systemFont(ofSize: 24, weight: .bold)
        textColor = UIColor.hexStringToUIColor(hex: "3B4651")
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
