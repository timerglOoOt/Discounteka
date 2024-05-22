import UIKit

// MARK: Расширение для UIButton, с картинкой и текстом заданного размера

class UICustomButton: UIButton {
    override var intrinsicContentSize: CGSize {
        CGSize(width: 350, height: 65)
    }

    init(_ title: String) {
        super.init(frame: .zero)

        // FIXME: Поменять местами текст с картинкой

        setTitle(title, for: .normal)
        layer.cornerRadius = 14
        clipsToBounds = true
        backgroundColor = UIColor.hexStringToUIColor(hex: "2B83FF")
        tintColor = .white
        setTitleColor(.gray, for: .highlighted)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
