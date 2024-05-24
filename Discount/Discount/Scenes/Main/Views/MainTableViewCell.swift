import UIKit
import SnapKit
import AVFoundation

// MARK: Кастомная ячейка главного экрана

final class MainTableViewCell: UITableViewCell {
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()

    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "textColor")
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
        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = UIColor(named: "backgroundColor")

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
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        cardNameLabel.text = card.name
        cardImageView.image = generateImage(from: card.code, cardType: card.type)

        cardImageView.isHidden = !card.isClicked
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImageView.image = nil
        cardNameLabel.text = nil
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
//    }

    private func generateImage(from string: String, cardType: AVMetadataObject.ObjectType) -> UIImage? {
        let data = Data(string.utf8)
        var filter: CIFilter = CIFilter()

        switch cardType {
        case .qr:
            filter = CIFilter.qrCodeGenerator()
        case .code128:
            filter = CIFilter.code128BarcodeGenerator()
        default:
            break
        }

        filter.setValue(data, forKey: "inputMessage")

        guard let output = filter.outputImage else { return nil }
        let scaleX = 200 / output.extent.size.width
        let scaleY = (cardType == .qr ? 200 : 130) / output.extent.size.height

        let transformedImage = output.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        let context = CIContext()
        if let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return UIImage(ciImage: transformedImage)
    }
}
