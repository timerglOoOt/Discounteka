import UIKit

// MARK: Расширение для UIButton, с картинкой и текстом заданного размера

final class UICustomButton: UIButton {
    override var intrinsicContentSize: CGSize {
        CGSize(width: 350, height: 65)
    }

    init(_ title: String) {
        super.init(frame: .zero)

        configureButton(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UICustomButton {
    func configureButton(title: String) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 14
        clipsToBounds = true
        backgroundColor = UIColor.hexStringToUIColor(hex: "2B83FF")
        tintColor = .white
        setTitleColor(.gray, for: .highlighted)
    }
}
