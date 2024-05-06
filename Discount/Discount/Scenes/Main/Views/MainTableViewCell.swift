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

        cardNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }
}

// MARK: Конфигурация и подготовка ячеек

extension MainTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func configureCell(card: Card, isClicked: Bool) {
        cardNameLabel.text = card.name
        cardImageView.image = UIImage(cgImage: card.code)
        setupLayout()

//        if card.type == .withQR {
//            cardImageView.snp.makeConstraints { make in
//                make.top.equalTo(cardNameLabel.snp.bottom).offset(10)
//            }
//        }
        if isClicked {
            if cardImageView.superview == nil {
                contentView.addSubview(cardImageView)
            }
            cardImageView.snp.makeConstraints { make in
                make.top.equalTo(cardNameLabel.snp.bottom).offset(10)
                make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
                make.size.equalTo(190)

            }
        } else {
            cardImageView.removeFromSuperview()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImageView.image = nil
        cardNameLabel.text = nil
    }
}
