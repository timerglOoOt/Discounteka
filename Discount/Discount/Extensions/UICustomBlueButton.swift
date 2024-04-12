import UIKit

// MARK: Кастомная синяя кнопка (пока не совсем работает)

class UICustomBlueButton: UIButton {
    private let defaultHeight: CGFloat = 65.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: defaultHeight)
    }
    init(_ title: String, _ icon: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setImage(UIImage(named: icon), for: [.normal, .highlighted])
        layer.cornerRadius = 14
        clipsToBounds = true
        backgroundColor = UIColor.hexStringToUIColor(hex: "F4FAFF")
        tintColor = .white
        layer.borderColor = UIColor.hexStringToUIColor(hex: "2B83FF").cgColor
        layer.borderWidth = 1.5
        setTitleColor(UIColor.hexStringToUIColor(hex: "2B83FF"), for: .normal)
        setTitleColor(.gray, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
