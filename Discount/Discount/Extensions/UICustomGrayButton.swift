import UIKit

// MARK: Кастомная серая кнопка (пока не совсем работает)

class UICustomGrayButton: UIButton {
    private let defaultHeight: CGFloat = 65.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: defaultHeight)
    }
    init(_ title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        layer.cornerRadius = 14
        clipsToBounds = true
        layer.borderColor = UIColor.hexStringToUIColor(hex: "2B83FF").cgColor
        layer.borderWidth = 1.5
        setTitleColor(UIColor.hexStringToUIColor(hex: "2B83FF"), for: .normal)
        setTitleColor(.gray, for: .highlighted)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
