import UIKit
import SnapKit

// MARK: Кастомная кнопка перехода не предыдущий экран с названием страницы

class UICustomBackItem: UIView {
    private lazy var backItemImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.backward"))
        image.tintColor = UIColor(named: "textColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(titleLabel: String) {
        super.init(frame: .zero)

        self.titleLabel.text = titleLabel
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 25, height: 25)
    }
}

// MARK: - Работа с положением элементов на CustomInfoLabel

extension UICustomBackItem {
    private func setupLayout() {
        addSubview(backItemImageView)
        addSubview(titleLabel)

        backItemImageView.snp.makeConstraints { make in
            make.centerY.leading.equalTo(safeAreaLayoutGuide)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(backItemImageView.snp.trailing).offset(10)
        }
    }
}
