import UIKit
import SnapKit

final class NewCardView: UIView {
    private lazy var enterCardNumberCustomLabel = UICustomLabel(labelText: "Вы можете ввести номер карты вручную", alignment: .center)
    private lazy var cardNumberCustomTextField = UICustomTextField(placeholderText: "Введите номер...")
    private lazy var scanQRCustomLabel = UICustomLabel(labelText: "или отсканировать QR-код", alignment: .center)
    private lazy var scanQRCustomBlueButton = UICustomGrayButton("Сканировать")
    private lazy var enterCardNameCustomLabel = UICustomLabel(labelText: "Введите название карты", alignment: .center)
    private lazy var cardNameCustomTextField = UICustomTextField(placeholderText: "Введите название...")
    private lazy var saveCustomButton = UICustomButton("Сохранить", "checkmark.circle")

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewCardView {
    private func setupLayout() {
        backgroundColor = .white
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
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(65)
            make.width.equalTo(350)
        }
    }
}
