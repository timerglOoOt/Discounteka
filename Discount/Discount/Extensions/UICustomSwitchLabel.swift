import UIKit

class UICustomSwitchLabel: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "standartTextColor")
        return label
    }()
    private lazy var switcher = UISwitch()

    init(text: String, isOn: Bool, isEnabled: Bool, action: UIAction) {
        super.init(frame: .zero)

        configureLabel(text: text, isOn: isOn, isEnabled: isEnabled, action: action)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UICustomSwitchLabel {
    func configureLabel(text: String, isOn: Bool, isEnabled: Bool, action: UIAction) {
        label.text = text
        switcher.isOn = isOn
        switcher.isEnabled = isEnabled
        switcher.addAction(action, for: .touchUpInside)
    }

    func setupLayout() {
        addSubview(label)
        addSubview(switcher)
        label.snp.makeConstraints { make in
            make.leading.centerY.equalTo(safeAreaLayoutGuide)
        }

        switcher.snp.makeConstraints { make in
            make.trailing.centerY.equalTo(safeAreaLayoutGuide)
        }

        self.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

extension UICustomSwitchLabel {
    func setAvilability(isEnabled: Bool) {
        switcher.isEnabled = isEnabled
        if !isEnabled {
            switcher.isOn = false
        }
    }
}
