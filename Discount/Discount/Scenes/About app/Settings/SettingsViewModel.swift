import Foundation
import UIKit

final class SettingsViewModel {
    weak var delegate: SignOutOutput?
    weak var controller: SettingsViewController?
    func systemThemeSwitchLabelTapped() -> Bool {
        let newTheme: Theme = Theme.current == .system ? .light : .system
        newTheme.applyTheme()
        newTheme.save()
        return newTheme != .system
    }

    func darkThemeSwitchLabelTapped() {
        let newTheme: Theme = Theme.current == .light ? .dark : .light
        newTheme.applyTheme()
        newTheme.save()
    }

    func notificationSwitchLabelTapped() {
        // TODO: добавить уведомления
        print("Notification")
    }

    func signOutLabelTapped() {
        delegate?.signedOutUser()
    }

    @MainActor
    func goToSettings(url: URL) {
        Task {
            await UIApplication.shared.open(url)
        }
    }
}
