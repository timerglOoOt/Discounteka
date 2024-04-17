import UIKit
import SnapKit

// MARK: Кастомная ячейка главного экрана

class MainTableViewCell: UITableViewCell {
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "3B4651")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Работа с положением элементов на MainTableCell

extension MainTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func cardWithBarcodeSetupLayout() {
        contentView.backgroundColor = .white

        contentView.addSubview(cardNameLabel)
        contentView.addSubview(cardImageView)

        cardNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(20)
        }

        cardImageView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }

    func cardWithQRSetupLayout() {
        contentView.backgroundColor = .white

        contentView.addSubview(cardNameLabel)
        contentView.addSubview(cardImageView)

        cardNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(20)
        }

        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(cardNameLabel.snp.bottom).inset(15)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
}

// MARK: Конфигурация и подготовка ячеек

extension MainTableViewCell {
    func configureCardWithBarcodeCell(card: CardWithBarcode) {
        cardWithBarcodeSetupLayout()

        cardNameLabel.text = card.name
        cardImageView.image = card.barcode.image
        cardImageView.isHidden = card.isClicked ? false : true
    }

    func configureCardWithQRCell(card: CardWithQR) {
        cardWithQRSetupLayout()

        cardNameLabel.text = card.name
        cardImageView.image = card.qrcode.image
        cardImageView.isHidden = card.isClicked ? false : true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImageView.image = nil
        cardNameLabel.text = nil
    }
}
