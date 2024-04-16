import UIKit

// MARK: Кастомное поле ввода данных

class UICustomTextField: UITextField, UITextFieldDelegate {
    private let defaultHeight: CGFloat = 60.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: defaultHeight)
    }

    init(placeholderText: String) {
        super.init(frame: .zero)

        delegate = self

        // TODO: Подумать, как всю эту простыню сократить

        placeholder = placeholderText
        font = .systemFont(ofSize: 22)
        layer.cornerRadius = 14
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.hexStringToUIColor(hex: "B8B8B8").cgColor
        layer.masksToBounds = true
        let clearButton = UIButton(type: .system)
        clearButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.imageView?.contentMode = .scaleAspectFit
        clearButton.addAction(UIAction(handler: { _ in
            self.text = ""
        }), for: .touchUpInside)
        rightView = clearButton
        rightView?.tintColor = .lightGray
        rightViewMode = .always
        indent(size: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Настройка работы с текстовым полем во все этапы ввода данных

extension UICustomTextField {
    func indent(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.hexStringToUIColor(hex: "2B83FF").cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.hexStringToUIColor(hex: "B8B8B8").cgColor
    }
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 40, y: 0, width: 40, height: bounds.height)
    }
}
