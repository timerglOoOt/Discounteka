import Foundation

class SettingsViewModel {
    weak var delegate: SignOutOutput?
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
}
