import UIKit
import SnapKit

// MARK: Кастомная ячейка главного экрана

final class MainTableViewCell: UITableViewCell {
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
//        image.snp.makeConstraints {
//            $0.width.height.equalTo(128)
//        }
        image.isHidden = true
        return image
    }()

    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "3B4651")
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardNameLabel, cardImageView])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Работа с положением элементов на MainTableCell

private extension MainTableViewCell {

    func setupLayout() {
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
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
        cardImageView.image = generateImage(from: card.code, cardType: card.type)

        cardImageView.isHidden = !card.isClicked
    }

    override func prepareForReuse() {
        super.prepareForReuse()


        cardImageView.image = nil
        cardNameLabel.text = nil
    }

    private func generateImage(from string: String, cardType: CardType) -> UIImage? {
        let data = Data(string.utf8)

        let filter: CIFilter = cardType.isBarcode ?
            CIFilter.barcodeGenerator() :
            CIFilter.qrCodeGenerator()

        filter.setValue(data, forKey: "inputMessage")

        guard let output = filter.outputImage else { return nil }
        let scaleX = 200 / output.extent.size.width
        let scaleY = 200 / output.extent.size.height

        let transformedImage = output.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        return UIImage(ciImage: transformedImage)
    }
}
