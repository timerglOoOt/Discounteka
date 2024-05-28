import UIKit

class SettingsViewController: UIViewController {
    private let viewModel: SettingsViewModel
    private let settingsView = SettingsView(frame: .zero)

    override func loadView() {
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        settingsView.delegate = self
    }

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsViewController {
    func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: Strings.settings)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func signOutLabelTapped() {
        viewModel.signOutLabelTapped()
    }

    func systemThemeSwitchLabelTapped() {
        let isEnabled = viewModel.systemThemeSwitchLabelTapped()
        settingsView.setDarkSwitchLabelAvailability(isEnabled: isEnabled)
    }

    func darkThemeSwitchLabelTapped() {
        viewModel.darkThemeSwitchLabelTapped()
    }

    func notificationSwitchLabelTapped() {
        viewModel.notificationSwitchLabelTapped()
    }
}
