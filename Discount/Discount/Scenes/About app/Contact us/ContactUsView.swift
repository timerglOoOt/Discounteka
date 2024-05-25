import UIKit

protocol ContactUsViewProtocol: AnyObject {
    func sendButtonTapped(message: String)
}

final class ContactUsView: UIView {
    private lazy var contactUsNameLabel: UICustomLabel = UICustomLabel(
        labelText: "Ваше мнение очень важно для нас",
        alignment: .center)
    private lazy var messageTextField = UICustomTextView(placeholderText: "Введите сообщение...")
    private lazy var sendMessageButton: UICustomButton = {
        let button = UICustomButton("Отправить")
        button.addAction(UIAction( handler: { [weak self] _ in
            guard let message = self?.messageTextField.text else { return }
            self?.delegate?.sendButtonTapped(message: message)
        }), for: .touchUpInside)
        return button
    }()
    weak var delegate: ContactUsViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ContactUsView {
    func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")

        addSubview(contactUsNameLabel)
        addSubview(messageTextField)
        addSubview(sendMessageButton)

        contactUsNameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(contactUsNameLabel.snp.bottom).offset(32)
            make.height.equalTo(150)
        }
        sendMessageButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension ContactUsView {
    func checkTextViewIsEmpty() -> Bool {
        return messageTextField.isEmptyTextView()
    }
}
