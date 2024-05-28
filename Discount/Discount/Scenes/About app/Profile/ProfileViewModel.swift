import Foundation

final class ProfileViewModel {
    weak var controller: ProfileViewController?
    private lazy var firebase = FirebaseManager(alertShowable: controller)

    func updateUser(firstName: String, lastName: String) {
        Task {
            await firebase.updateUser(firstName: firstName, lastName: lastName)
        }
    }
}
