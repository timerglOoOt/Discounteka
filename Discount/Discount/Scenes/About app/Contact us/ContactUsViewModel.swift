import Foundation

protocol ContactUsViewModelProtocol: AnyObject {
    func sendMessage(messageText: String)
}

final class ContactUsViewModel {
    weak var controller: ContactUsViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func sendMessage(messageText: String) {
        Task {
            await firebase.addMessage(messageText: messageText)
        }
    }
}
