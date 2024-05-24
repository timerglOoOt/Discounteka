import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    func enterLabelTapped()
    func signUpButtonTapped()
}

final class SignUpView: UIView {
    private lazy var welcomeCustomeLabel = UICustomLabel(
        labelText: "Discounteka - лучший друг человека!",
        alignment: .center)
    private lazy var firstNameCustomTextField = UICustomTextField(placeholderText: "Имя")
    private lazy var lastNameCustomTextField = UICustomTextField(placeholderText: "Фамилия")
    private lazy var emailCustomTextField = UICustomTextField(placeholderText: "Почта")
    private lazy var passwordCustomTextField = UICustomTextField(placeholderText: "Пароль")
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "DBD7D7")
        return label
    }()

    private lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor.hexStringToUIColor(hex: "2B83FF")
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstNameCustomTextField, lastNameCustomTextField,
            emailCustomTextField, passwordCustomTextField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var entryInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoLabel, enterLabel])
        stack.spacing = 2
        stack.axis = .horizontal
        stack.contentMode = .center
        return stack
    }()

    private lazy var signUpCustomButton: UICustomButton = {
        let button = UICustomButton("Зарегистрироваться")
        button.addAction(UIAction { [weak self] _ in
            self?.delegate?.signUpButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    weak var delegate: SignUpViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpView {
    func setupLayout() {
        backgroundColor = .systemBackground
        passwordCustomTextField.isSecureTextEntry = true
        addSubview(welcomeCustomeLabel)
        addSubview(textFieldsStack)
        addSubview(signUpCustomButton)
        addSubview(entryInfoStack)

        welcomeCustomeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
        }
        textFieldsStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        signUpCustomButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
        }
        entryInfoStack.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(signUpCustomButton.snp.bottom).offset(8)
        }
    }

    func setupGesture() {
        let enterLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        enterLabel.addGestureRecognizer(enterLabelTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        delegate?.enterLabelTapped()
    }
}

extension SignUpView {
    func configureSignUpForm() -> (User, String) {
        let form = (User(
            firstName: firstNameCustomTextField.text ?? "",
            lastName: lastNameCustomTextField.text ?? "",
            email: emailCustomTextField.text ?? "",
            sex: 0, cards: []),
            passwordCustomTextField.text ?? "")

        return form
    }
}
