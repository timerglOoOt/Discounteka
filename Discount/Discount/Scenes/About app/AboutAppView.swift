import UIKit

final class AboutAppView: UIView {
    private lazy var profileAppInfoLabel: UICustomInfoLabel = {
        let label = UICustomInfoLabel(imageName: "star.svg", text: "Профиль")
        label.tag = 1
        return label
    }()

    private lazy var settingsAppInfoLabel: UICustomInfoLabel = {
        let label = UICustomInfoLabel(imageName: "share.svg", text: "Настройки")
        label.tag = 2
        return label
    }()

    private lazy var contactAppInfoLabel: UICustomInfoLabel = {
        let label = UICustomInfoLabel(imageName: "contact.svg", text: "Свяжитесь с нами")
        label.tag = 3
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            profileAppInfoLabel,
            settingsAppInfoLabel,
            contactAppInfoLabel
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

private extension AboutAppView {
    private func setupLayout() {
        backgroundColor = .white
        addSubview(infoStackView)

        infoStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }

    private func setupGestures() {
        let profileAppTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        profileAppInfoLabel.addGestureRecognizer(profileAppTapGesture)
        let settingsAppTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        settingsAppInfoLabel.addGestureRecognizer(settingsAppTapGesture)
        let contactAppTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLableTap))
        contactAppInfoLabel.addGestureRecognizer(contactAppTapGesture)
    }

    @objc func handleLableTap(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        labelTappedClosure?(tag)
    }
}
