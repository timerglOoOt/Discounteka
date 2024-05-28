import UIKit
import SnapKit

// MARK: Кастомный label с картинкой

final class UICustomInfoLabel: UIView {
    private lazy var infoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 14
        image.layer.masksToBounds = true
        return image
    }()

    private lazy var infoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: "textColor")
        label.numberOfLines = .zero
        return label
    }()

    init(imageName: String, text: String) {
        super.init(frame: .zero)

        infoImageView.image = UIImage(named: imageName)
        infoDescriptionLabel.text = text
        layer.cornerRadius = 14

        setupLayout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        CGSize(width: 350, height: 50)
    }
}

// MARK: - Работа с положением элементов на CustomInfoLabel

private extension UICustomInfoLabel {
    func setupLayout() {
        backgroundColor = .clear

        addSubview(infoImageView)
        addSubview(infoDescriptionLabel)

        infoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.size.equalTo(44)
        }

        infoDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(infoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }

    // MARK: - Работа с нажатиями на label

    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGesture)

        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = UIColor(named: "backgroundColor")
        }
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0.3) {
                self.backgroundColor = UIColor(named: "infoLabelColor")
            }
        }
    }

    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = UIColor(named: "infoLabelColor")
            }
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = UIColor(named: "backgroundColor")
            }
        }
    }
}
