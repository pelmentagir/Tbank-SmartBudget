import Foundation

final class RegistrationViewModel {

    // MARK: Published Properties
    @Published private(set) var isRegistration: Bool = false
    @Published private(set) var user: User?

    // MARK: Public Methods
    func isPasswordValid(with passwordText: String, confirmText: String) -> Bool {
        return passwordText == confirmText
    }

    func registrationUser(login: String, password: String) {
        guard !isRegistration else { return }

        isRegistration = true

        // TODO: Запрос в бд, пока что имитация
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.user = User(login: login, password: password)
            self?.isRegistration = false
        }
    }
}
