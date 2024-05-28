import Foundation
import Firebase
import UIKit

protocol AlertShowable {
    func showCustomAlertAsync(title: String, message: String) async
    func showCustomAlert(title: String, message: String)
}

class FirebaseManager {
    private let dataBase = Firestore.firestore()
    private var alertShowable: AlertShowable?

    init(alertShowable: AlertShowable?) {
        self.alertShowable = alertShowable
    }

    func createUser(user: User, password: String) async -> String? {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: user.email, password: password)
            let uid = authResult.user.uid
            try await authResult.user.sendEmailVerification()

            let userData: [String: Any] = [
                "firstName": user.firstName,
                "lastName": user.lastName,
                "email": user.email,
                "sex": user.sex,
                "cards": user.cards.map { card in
                    return [
                        "type": card.type == .qr,
                        "name": card.name,
                        "code": card.code
                    ]
                }
            ]

            try await dataBase.collection("users").document(uid).setData(userData)
            print("User created successfully with authentication.")
            return uid
        } catch {
            print("Error creating user with authentication: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error creating user with authentication: \(error.localizedDescription)")
        }
        return nil
    }

    func signInUser(email: String?, password: String?) async -> String {
        guard let email = email, let password = password else {
            print("Found empty textField!")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Found empty textField!")
            return ""
        }
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("User signed in successfully with email: \(authResult.user.email ?? "")")
            return authResult.user.uid
        } catch {
            print("Error signing in user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error signing in user: \(error.localizedDescription)")
        }
        return ""
    }

    func getUser(withId id: String) async -> User? {
        do {
            let document = try await dataBase.collection("users").document(id).getDocument()
            guard let data = document.data() else {
                return nil
            }
            return parseUserData(data: data)
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }

    func updateUser(firstName: String, lastName: String) async {
        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName
        ]

        do {
            guard let uid = UserDefaults.standard.string(forKey: "curUser") else { return }
            try await dataBase.collection("users").document(uid).updateData(userData)
            print("User updated successfully.")
        } catch {
            print("Error updating user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error updating user: \(error.localizedDescription)")
        }
    }

    func deleteUser(withId id: String) async {
        do {
            try await dataBase.collection("users").document(id).delete()
            print("User deleted successfully.")
        } catch {
            print("Error deleting user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error deleting user: \(error.localizedDescription)")
        }
    }

    func addCard(toUserId userId: String, card: Card) async {
        let cardData: [String: Any] = [
            "type": card.type == .qr,
            "name": card.name,
            "code": card.code
        ]

        do {
            try await dataBase.collection("users").document(userId).updateData([
                "cards": FieldValue.arrayUnion([cardData])
            ])
            print("Card added to user successfully.")
        } catch {
            print("Error adding card to user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error adding card to user: \(error.localizedDescription)")
        }
    }

    func removeCard(fromUserId userId: String, card: Card) async {
        let cardData: [String: Any] = [
            "type": card.type == .qr,
            "name": card.name,
            "code": card.code
        ]

        do {
            try await dataBase.collection("users").document(userId).updateData([
                "cards": FieldValue.arrayRemove([cardData])
            ])
            print("Card removed from user successfully.")
        } catch {
            print("Error removing card from user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error removing card from user: \(error.localizedDescription)")
        }
    }

    func getCards(forUserId userId: String) async -> [Card]? {
        do {
            let document = try await dataBase.collection("users").document(userId).getDocument()
            guard let data = document.data(), let cardsData = data["cards"] as? [[String: Any]] else {
                return nil
            }
            return cardsData.compactMap { cardData -> Card? in
                guard let type = cardData["type"] as? Bool,
                    let name = cardData["name"] as? String,
                    let code = cardData["code"] as? String else {
                    return nil
                }
                return Card(type: type ? .qr : .code128, isClicked: false, name: name, code: code)
            }
        } catch {
            print("Error fetching cards for user: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error fetching cards for user: \(error.localizedDescription)")
            return nil
        }
    }

    func addMessage(messageText: String) async {
        guard let curUser = UserDefaults.standard.string(forKey: "curUser") else {
            print("User ID not found in UserDefaults")
            return
        }
        let message = Message(userId: curUser, message: messageText)
        let messageDict: [String: Any] = ["userId": message.userId, "message": message.message, "timestamp": Timestamp(date: Date())]
        do {
            let ref = try await dataBase.collection("messages").addDocument(data: messageDict)
            print("Message added with ID: \(ref.documentID)")
        } catch {
            print("Error sending message for us: \(error.localizedDescription)")
            await alertShowable?.showCustomAlertAsync(title: "Error", message: "Error sending message for us: \(error.localizedDescription)")
        }
    }

    private func parseUserData(data: [String: Any]) -> User? {
        guard let firstName = data["firstName"] as? String,
            let lastName = data["lastName"] as? String,
            let email = data["email"] as? String,
            let sex = data["sex"] as? Int,
            let cardsData = data["cards"] as? [[String: Any]] else {
            return nil
        }
        let cards = cardsData.compactMap { cardData -> Card? in
            guard let type = cardData["type"] as? Bool,
                let name = cardData["name"] as? String,
                let code = cardData["code"] as? String else {
                return nil
            }
            return Card(type: type ? .qr : .code128, isClicked: false, name: name, code: code)
        }
        return User(firstName: firstName, lastName: lastName, email: email, sex: sex, cards: cards)
    }
}
