import UIKit

protocol ProfileViewProtocol: AnyObject {
    func saveButtonTapped(firstName: String, lastName: String)
    func showAlert()
}

final class ProfileView: UIView {
    private lazy var profileLabel = UICustomLabel(labelText: "You can change your personal data".localized(), alignment: .center)
    private lazy var firstNameTextField = UICustomTextField(placeholderText: "Name".localized())
    private lazy var lastNameTextField = UICustomTextField(placeholderText: "Surname".localized())

    private lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField])
        stack.spacing = 16
        stack.axis = .vertical
        return stack
    }()

    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileLabel, textFieldsStack])
        stack.spacing = 24
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()

    private lazy var saveButton: UICustomButton = {
        let button = UICustomButton("Save".localized())
        button.addAction(UIAction { [weak self] _ in
            let first = self?.firstNameTextField.isEmptyTextField()
            let second = self?.lastNameTextField.isEmptyTextField()
            if first ?? true || second ?? true {
                self?.delegate?.showAlert()
                return
            }
            self?.delegate?.saveButtonTapped(
                firstName: self?.firstNameTextField.text ?? "",
                lastName: self?.lastNameTextField.text ?? ""
            )
        }, for: .touchUpInside)
        return button
    }()
    weak var delegate: ProfileViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")
        addSubview(profileStack)
        addSubview(saveButton)

        profileStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
