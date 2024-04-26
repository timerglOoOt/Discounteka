import UIKit
import SnapKit

// MARK: Кастомная ячейка главного экрана

final class MainTableViewCell: UITableViewCell {
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "3B4651")
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

private extension MainTableViewCell {
    func setupLayout() {
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
}

// MARK: Конфигурация и подготовка ячеек

extension MainTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func configureCell(card: Card) {
        cardNameLabel.text = card.name
        cardImageView.isHidden = card.isClicked ? false : true
        cardImageView.image = UIImage(cgImage: card.code)
        setupLayout()

        if card.type == .withQR {
            cardImageView.snp.makeConstraints { make in
                make.top.equalTo(cardNameLabel.snp.bottom).offset(10)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImageView.image = nil
        cardNameLabel.text = nil
    }
}
