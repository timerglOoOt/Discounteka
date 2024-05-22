import UIKit
import SnapKit

class NewCardChoiseView: UIView {
    private lazy var newCardsNameLabel: UICustomLabel = UICustomLabel(
        labelText: "Какую карту вы хотели бы добавить?",
        alignment: .left)

    private lazy var cardWithQRInfoLabel = UICustomInfoLabel(imageName: "scanQR.svg", text: "С QR-кодом")
    private lazy var cardWithBarcodeInfoLabel = UICustomInfoLabel(imageName: "scanBarcode.svg", text: "Со шрихкодом")

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            cardWithQRInfoLabel,
            cardWithBarcodeInfoLabel
        ])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()

    var labelTappedClosure: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewCardChoiseView {
    func setupLayout() {
        backgroundColor = .systemBackground
        cardWithQRInfoLabel.tag = 1
        cardWithBarcodeInfoLabel.tag = 2
        addSubview(infoStackView)
        addSubview(newCardsNameLabel)

        newCardsNameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.trailing.equalToSuperview()
        }

        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(newCardsNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }

    private func setupGestures() {
        let cardWithQRTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        cardWithQRInfoLabel.addGestureRecognizer(cardWithQRTapGesture)
        let cardWithBarcodeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        cardWithBarcodeInfoLabel.addGestureRecognizer(cardWithBarcodeTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        labelTappedClosure?(tag)
    }
}
