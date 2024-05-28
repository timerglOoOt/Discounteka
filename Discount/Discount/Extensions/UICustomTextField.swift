import UIKit

// MARK: Кастомное поле ввода данных

final class UICustomTextField: UITextField, UITextFieldDelegate {
    private let defaultHeight: CGFloat = 60.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: defaultHeight)
    }

    init(placeholderText: String) {
        super.init(frame: .zero)

        delegate = self
        configureTextField(placeholderText: placeholderText)
//        configureDoneButton()
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
    @discardableResult
    func isEmptyTextField() -> Bool {
        if self.text?.isEmpty ?? true {
            self.layer.borderColor = UIColor.hexStringToUIColor(hex: "E33A43").cgColor
        }
        return self.text?.isEmpty ?? true
    }
}

// MARK: настройка конфигурации поля и клавиатуры

private extension UICustomTextField {
    func configureDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: false)
        inputAccessoryView = toolbar
    }

    @objc private func doneButtonTapped() { resignFirstResponder() }

    func configureTextField(placeholderText: String) {
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
}
