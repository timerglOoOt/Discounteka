import Foundation

enum Sex {
    case none
    case male
    case femsle
}

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let sex: Int
    let cards: [Card]
}
