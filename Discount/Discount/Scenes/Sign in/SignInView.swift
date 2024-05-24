import UIKit
import SnapKit

protocol SignInViewProtocol: AnyObject {
    func signUpLabelTapped()
    func signInButtonTapped()
}

final class SignInView: UIView {
    private lazy var welcomeCustomeLabel = UICustomLabel(
        labelText: "Discounteka - лучший друг человека!",
        alignment: .center)
    private lazy var emailCustomTextField = UICustomTextField(placeholderText: "Почта")
    private lazy var passwordCustomTextField = UICustomTextField(placeholderText: "Пароль")
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас еще нет аккаунта?"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "DBD7D7")
        return label
    }()

    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Зарегистрироваться"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor.hexStringToUIColor(hex: "2B83FF")
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailCustomTextField, passwordCustomTextField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var signUpInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoLabel, signUpLabel])
        stack.spacing = 2
        stack.axis = .horizontal
        stack.contentMode = .center
        return stack
    }()

    private lazy var signUpCustomButton: UICustomButton = {
        let button = UICustomButton("Войти")
        button.addAction(UIAction { [weak self] _ in
            self?.delegate?.signInButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    weak var delegate: SignInViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInView {
    func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")
        passwordCustomTextField.isSecureTextEntry = true
        addSubview(welcomeCustomeLabel)
        addSubview(textFieldsStack)
        addSubview(signUpCustomButton)
        addSubview(signUpInfoStack)

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
        signUpInfoStack.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(signUpCustomButton.snp.bottom).offset(8)
        }
    }

    func setupGesture() {
        let signUpLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        signUpLabel.addGestureRecognizer(signUpLabelTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        delegate?.signUpLabelTapped()
    }
}

extension SignInView {
    func configureSignInForm() -> (String?, String?) {
        return (emailCustomTextField.text, passwordCustomTextField.text)
    }
}
