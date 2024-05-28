import UIKit

// MARK: Кастомное поле ввода данных в большом объеме

final class UICustomTextView: UITextView {
    init(placeholderText: String) {
        super.init(frame: .zero, textContainer: .none)
        self.placeholderText = placeholderText

        delegate = self

        font = .systemFont(ofSize: 22)
        backgroundColor = .clear
        layer.cornerRadius = 14
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.hexStringToUIColor(hex: "B8B8B8").cgColor
        layer.masksToBounds = true
        textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        editPlaceholder(textView: self)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var placeholderText: String?
}

// MARK: - Настройка работы с текстовым полем во все этапы ввода данных

extension UICustomTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.hexStringToUIColor(hex: "2B83FF").cgColor
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = UIColor(named: "standartTextColor")
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.hexStringToUIColor(hex: "B8B8B8").cgColor
        if textView.text.isEmpty {
            editPlaceholder(textView: textView)
        }
    }

    private func editPlaceholder(textView: UITextView) {
        textView.text = placeholderText
        textView.textColor = .systemGray3
    }

    func isEmptyTextView() -> Bool {
        if self.text == placeholderText || self.text.isEmpty {
            self.layer.borderColor = UIColor.hexStringToUIColor(hex: "E33A43").cgColor
        }
        return self.text == placeholderText || self.text.isEmpty
    }
}
