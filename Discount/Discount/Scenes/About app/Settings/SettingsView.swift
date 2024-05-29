import UIKit

protocol SettingsViewProtocol: AnyObject {
    func systemThemeSwitchLabelTapped()
    func darkThemeSwitchLabelTapped()
    func notificationSwitchLabelTapped()
    func signOutLabelTapped()
    func settingsLanguageLabelTapped()
}

final class SettingsView: UIView {
    private let isSystem = UserDefaults.standard.string(forKey: "currentTheme") == "system"
    private let isDark = UserDefaults.standard.string(forKey: "currentTheme") == "dark"
    private lazy var themeLabel = UICustomLabel(labelText: Strings.theme, alignment: .left)
    private lazy var systemThemeSwitchLabel = UICustomSwitchLabel(
        text: Strings.systemTheme, isOn: isSystem, isEnabled: true,
        action: UIAction { [weak self] _ in
            self?.delegate?.systemThemeSwitchLabelTapped()
    })
    private lazy var darkThemeSwitchLabel = UICustomSwitchLabel(
        text: Strings.darkTheme, isOn: isDark, isEnabled: !isSystem,
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

    private lazy var notificationLabel = UICustomLabel(labelText: Strings.notifications, alignment: .left)
    private lazy var notificationSwitchLabel = UICustomSwitchLabel(
        text: Strings.allowNotifications, isOn: false, isEnabled: true,
        action: UIAction { [weak self] _ in
            self?.delegate?.notificationSwitchLabelTapped()
    })
    private lazy var notificationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitchLabel])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private lazy var languageLabel = UICustomLabel(labelText: Strings.language, alignment: .left)
    private lazy var languageSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.changeLanguage
        label.textColor = UIColor.hexStringToUIColor(hex: "2B83FF")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var languageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [languageLabel, languageSettingsLabel])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private lazy var settingsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [themeStack, notificationStack, languageStack])
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()

    private lazy var signOutLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.logOut
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
        addSubview(settingsStack)
        addSubview(signOutLabel)

        settingsStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
        }

        signOutLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }

    func setupGesture() {
        let signOutTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        signOutLabel.addGestureRecognizer(signOutTapGesture)
        let languageSettingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLanguageLableTap))
        languageSettingsLabel.addGestureRecognizer(languageSettingsTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        delegate?.signOutLabelTapped()
    }

    @objc func handleLanguageLableTap(sender: UITapGestureRecognizer) {
        delegate?.settingsLanguageLabelTapped()
    }
}

extension SettingsView {
    func setDarkSwitchLabelAvailability(isEnabled: Bool) {
        darkThemeSwitchLabel.setAvilability(isEnabled: isEnabled)
    }
    func toggleNotificationSwitcher() {
        notificationSwitchLabel.toggleSwitch()
    }
}
