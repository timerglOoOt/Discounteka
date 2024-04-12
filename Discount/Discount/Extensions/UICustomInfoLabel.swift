import UIKit

// MARK: Кастомный label с картинкой

class UICustomInfoLabel: UIView {
    private lazy var infoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 14
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var infoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.hexStringToUIColor(hex: "3B4651")
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
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

extension UICustomInfoLabel {
    private func setupLayout() {
        backgroundColor = .white

        addSubview(infoImageView)
        addSubview(infoDescriptionLabel)

        NSLayoutConstraint.activate([
            infoImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            infoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: 44),
            infoImageView.widthAnchor.constraint(equalToConstant: 44),

            infoDescriptionLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            infoDescriptionLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 10),
            infoDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // MARK: - Работа с нажатиями на label

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGesture)

        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = UIColor.hexStringToUIColor(hex: "F4FAFF")
        }
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0.3) {
                self.backgroundColor = .white
            }
        }
    }

    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = UIColor.hexStringToUIColor(hex: "F4FAFF")
            }
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = .white
            }
        }
    }
}
