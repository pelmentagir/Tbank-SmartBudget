import Foundation

struct User {
    var name: String?
    var lastName: String?
    var login: String
    var password: String

    init(name: String? = nil, lastName: String? = nil, login: String, password: String) {
        self.name = name
        self.lastName = lastName
        self.login = login
        self.password = password
    }
}
