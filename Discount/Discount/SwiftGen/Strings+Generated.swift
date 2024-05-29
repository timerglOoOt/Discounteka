// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
    public enum Id {
      public enum Buttons {
        /// signUp
        public static let signUp = Strings.tr("UIdentifiers", "id.buttons.signUp", fallback: "signUp")
      }
      public enum TextFields {
        /// email
        public static let email = Strings.tr("UIdentifiers", "id.textFields.email", fallback: "email")
        /// info
        public static let info = Strings.tr("UIdentifiers", "id.textFields.info", fallback: "info")
        /// firstName
        public static let name = Strings.tr("UIdentifiers", "id.textFields.name", fallback: "firstName")
        /// lastName
        public static let surname = Strings.tr("UIdentifiers", "id.textFields.surname", fallback: "lastName")
      }
    }
  ///  barcode
  public static let barcode = Strings.tr("Localizable", " barcode", fallback: " barcode")
  ///  My cards
  public static let myCards = Strings.tr("Localizable", "  My cards", fallback: "  My cards")
  ///  QR code
  public static let qrCode = Strings.tr("Localizable", " QR code", fallback: " QR code")
  public static let withQrCode = Strings.tr("Localizable", "QR code", fallback: "QR code")
  public static let withBarcode = Strings.tr("Localizable", "Barcode", fallback: "Barcode")
  public static let enterTheName = Strings.tr("Localizable", "Enter the name...", fallback: "Enter the name...")
  /// About app
  public static let aboutApp = Strings.tr("Localizable", "About app", fallback: "About app")
  /// Add card
  public static let addCard = Strings.tr("Localizable", "Add card", fallback: "Add card")
  /// Allow notifications
  public static let allowNotifications = Strings.tr("Localizable", "Allow notifications", fallback: "Allow notifications")
  /// Already have an account?
  public static let alreadyHaveAnAccount = Strings.tr("Localizable", "Already have an account?", fallback: "Already have an account?")
  /// Card with
  public static let cardWith = Strings.tr("Localizable", "Card with", fallback: "Card with")
  /// Close
  public static let close = Strings.tr("Localizable", "Close", fallback: "Close")
  /// Contact us
  public static let contactUs = Strings.tr("Localizable", "Contact us", fallback: "Contact us")
  /// Dark theme
  public static let darkTheme = Strings.tr("Localizable", "Dark theme", fallback: "Dark theme")
  /// Discounteka is a person's best friend!
  public static let discountekaIsAPersonSBestFriend = Strings.tr("Localizable", "Discounteka is a person's best friend!", fallback: "Discounteka is a person's best friend!")
  /// Don't you have an account yet?
  public static let donTYouHaveAnAccountYet = Strings.tr("Localizable", "Don't you have an account yet?", fallback: "Don't you have an account yet?")
  /// Email
  public static let email = Strings.tr("Localizable", "Email", fallback: "Email")
  /// Enter message...
  public static let enterMessage = Strings.tr("Localizable", "Enter message...", fallback: "Enter message...")
  /// Enter the name of the card
  public static let enterTheNameOfTheCard = Strings.tr("Localizable", "Enter the name of the card", fallback: "Enter the name of the card")
  /// Enter the number...
  public static let enterTheNumber = Strings.tr("Localizable", "Enter the number...", fallback: "Enter the number...")
  /// Error
  public static let error = Strings.tr("Localizable", "Error", fallback: "Error")
  /// Log out
  public static let logOut = Strings.tr("Localizable", "Log out", fallback: "Log out")
  /// Name
  public static let name = Strings.tr("Localizable", "Name", fallback: "Name")
  /// New card
  public static let newCard = Strings.tr("Localizable", "New card", fallback: "New card")
  /// Notifications
  public static let notifications = Strings.tr("Localizable", "Notifications", fallback: "Notifications")
  /// or scan it
  public static let orScanIt = Strings.tr("Localizable", "or scan it", fallback: "or scan it")
  /// Password
  public static let password = Strings.tr("Localizable", "Password", fallback: "Password")
  /// Profile
  public static let profile = Strings.tr("Localizable", "Profile", fallback: "Profile")
  /// Save
  public static let save = Strings.tr("Localizable", "Save", fallback: "Save")
  /// Scan card
  public static let scanCard = Strings.tr("Localizable", "Scan card", fallback: "Scan card")
  /// Send message
  public static let sendMessage = Strings.tr("Localizable", "Send message", fallback: "Send message")
  /// Settings
  public static let settings = Strings.tr("Localizable", "Settings", fallback: "Settings")
  /// Sign in
  public static let signIn = Strings.tr("Localizable", "Sign in", fallback: "Sign in")
  /// Sign up
  public static let signUp = Strings.tr("Localizable", "Sign up", fallback: "Sign up")
  /// Surname
  public static let surname = Strings.tr("Localizable", "Surname", fallback: "Surname")
  /// System theme
  public static let systemTheme = Strings.tr("Localizable", "System theme", fallback: "System theme")
  /// Theme
  public static let theme = Strings.tr("Localizable", "Theme", fallback: "Theme")
  /// Which card would you like to add?
  public static let whichCardWouldYouLikeToAdd = Strings.tr("Localizable", "Which card would you like to add?", fallback: "Which card would you like to add?")
  /// You are trying to send an empty field! Please enter the text.
  public static let youAreTryingToSendAnEmptyFieldPleaseEnterTheText = Strings.tr("Localizable", "You are trying to send an empty field! Please enter the text.", fallback: "You are trying to send an empty field! Please enter the text.")
  /// You can change your personal data
  public static let youCanChangeYourPersonalData = Strings.tr("Localizable", "You can change your personal data", fallback: "You can change your personal data")
  /// You can enter the card number manually
  public static let youCanEnterTheCardNumberManually = Strings.tr("Localizable", "You can enter the card number manually", fallback: "You can enter the card number manually")
  /// Your opinion is very important to us
  public static let yourOpinionIsVeryImportantToUs = Strings.tr("Localizable", "Your opinion is very important to us", fallback: "Your opinion is very important to us")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable all
