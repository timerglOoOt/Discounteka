import UIKit

enum Theme: String {
    case system
    case light
    case dark

    static var current: Theme {
        if let savedTheme = UserDefaults.standard.string(forKey: "currentTheme") {
            return Theme(rawValue: savedTheme) ?? .system
        } else {
            return .system
        }
    }

    func applyTheme() {
        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }

        switch self {
        case .system:
            windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified
            }
        case .light:
            windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        case .dark:
            windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }

    func save() {
        UserDefaults.standard.set(self.rawValue, forKey: "currentTheme")
    }
}
