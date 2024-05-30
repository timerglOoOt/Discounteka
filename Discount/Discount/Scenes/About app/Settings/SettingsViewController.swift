import UIKit

final class SettingsViewController: UIViewController {
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
    func settingsLanguageLabelTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            showSettingsAlert(
                title: Strings.openSettings,
                message: Strings.settingsLanguageMessage,
                url: url,
                isSwitcher: false
            )
        }
    }

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
        if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
            showSettingsAlert(
                title: Strings.openSettings,
                message: Strings.settingsLanguageMessage,
                url: url,
                isSwitcher: true
            )
        }
    }
}

private extension SettingsViewController {
    func showSettingsAlert(title: String, message: String, url: URL, isSwitcher: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Strings.alertContinue, style: .default) { [weak self] _ in
            self?.viewModel.goToSettings(url: url)
        }
        alert.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel) { [weak self] _ in
            if isSwitcher {
                self?.settingsView.toggleNotificationSwitcher()
            }
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
