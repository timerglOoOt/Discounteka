import UIKit
import SnapKit

protocol NewCardSceneDelegate: AnyObject {
    func saveButtonTapped()
    func scanButtonTapped()
}

final class NewCardView: UIView {
    private lazy var enterCardNumberCustomLabel = UICustomLabel(labelText: Strings.youCanEnterTheCardNumberManually, alignment: .center)
    lazy var cardNumberCustomTextField = UICustomTextField(placeholderText: Strings.enterTheNumber)
    private lazy var scanQRCustomLabel = UICustomLabel(labelText: Strings.orScanIt, alignment: .center)
    private lazy var enterCardNameCustomLabel = UICustomLabel(labelText: Strings.enterTheNameOfTheCard, alignment: .center)
    private lazy var cardNameCustomTextField = UICustomTextField(placeholderText: Strings.enterTheName)
    private lazy var saveCustomButton: UICustomButton = {
        let button = UICustomButton(Strings.save)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.saveButtonTapped()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var scanQRCustomBlueButton: UICustomGrayButton = {
        let button = UICustomGrayButton(Strings.scanCard)
        let action = UIAction { [weak self] _ in
            self?.delegate?.scanButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    weak var delegate: NewCardSceneDelegate?
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getTextFields() -> (String, String) {
        return (cardNumberCustomTextField.text ?? "", cardNameCustomTextField.text ?? "")
    }
}

private extension NewCardView {
    private func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")
        addSubview(enterCardNumberCustomLabel)
        addSubview(cardNumberCustomTextField)
        addSubview(scanQRCustomLabel)
        addSubview(scanQRCustomBlueButton)
        addSubview(enterCardNameCustomLabel)
        addSubview(cardNameCustomTextField)
        addSubview(saveCustomButton)

        enterCardNumberCustomLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        cardNumberCustomTextField.snp.makeConstraints { make in
            make.top.equalTo(enterCardNumberCustomLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        scanQRCustomLabel.snp.makeConstraints { make in
            make.top.equalTo(cardNumberCustomTextField.snp.bottom).offset(25)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        scanQRCustomBlueButton.snp.makeConstraints { make in
            make.top.equalTo(scanQRCustomLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        enterCardNameCustomLabel.snp.makeConstraints { make in
            make.top.equalTo(scanQRCustomBlueButton.snp.bottom).offset(25)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        cardNameCustomTextField.snp.makeConstraints { make in
            make.top.equalTo(enterCardNameCustomLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }

        saveCustomButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension NewCardView {
    func checkIfTextFieldsIsEmpty() -> Bool {
        let first = cardNumberCustomTextField.isEmptyTextField()
        let second = cardNameCustomTextField.isEmptyTextField()
        return first || second
    }
}
