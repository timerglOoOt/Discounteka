import UIKit

protocol SettingsViewProtocol: AnyObject {
    func systemThemeSwitchLabelTapped()
    func darkThemeSwitchLabelTapped()
    func notificationSwitchLabelTapped()
    func signOutLabelTapped()
}

final class SettingsView: UIView {
    private let isSystem = UserDefaults.standard.string(forKey: "currentTheme") == "system"
    private let isDark = UserDefaults.standard.string(forKey: "currentTheme") == "dark"
    private lazy var themeLabel = UICustomLabel(labelText: "Theme".localized(), alignment: .left)
    private lazy var systemThemeSwitchLabel = UICustomSwitchLabel(
        text: "System theme".localized(), isOn: isSystem, isEnabled: true,
        action: UIAction { [weak self] _ in
            self?.delegate?.systemThemeSwitchLabelTapped()
    })
    private lazy var darkThemeSwitchLabel = UICustomSwitchLabel(
        text: "Dark theme".localized(), isOn: isDark, isEnabled: !isSystem,
        action: UIAction { [weak self] _ in
            self?.delegate?.darkThemeSwitchLabelTapped()
    })
    private lazy var themeSwitcherStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [systemThemeSwitchLabel, darkThemeSwitchLabel])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    private lazy var themeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [themeLabel, themeSwitcherStack])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private lazy var notificationLabel = UICustomLabel(labelText: "Notifications".localized(), alignment: .left)
    private lazy var notificationSwitchLabel = UICustomSwitchLabel(
        text: "Allow notifications".localized(), isOn: false, isEnabled: true,
        action: UIAction { [weak self] _ in
            self?.delegate?.notificationSwitchLabelTapped()
    })
    private lazy var notificationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitchLabel])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private lazy var signOutLabel: UILabel = {
        let label = UILabel()
        label.text = "Log out".localized()
        label.textColor = UIColor.hexStringToUIColor(hex: "E33A43")
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.isUserInteractionEnabled = true
        return label
    }()

    weak var delegate: SettingsViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsView {
    func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")
        addSubview(themeStack)
        addSubview(notificationStack)
        addSubview(signOutLabel)

        themeStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
        }
        notificationStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(themeStack.snp.bottom).offset(24)
        }
        signOutLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }

    func setupGesture() {
        let signOutTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        signOutLabel.addGestureRecognizer(signOutTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        delegate?.signOutLabelTapped()
    }
}

extension SettingsView {
    func setDarkSwitchLabelAvailability(isEnabled: Bool) {
        darkThemeSwitchLabel.setAvilability(isEnabled: isEnabled)
    }
}
