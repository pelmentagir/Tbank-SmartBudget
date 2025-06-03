import Foundation
import Combine

final class LoginViewModel {

    // MARK: Published Properties
    @Published private(set) var isPasswordVisible: Bool = false
    @Published private(set) var isAuthenticating: Bool = false
    @Published private(set) var user: AuthUser?

    // MARK: Public Methods
    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    func authenticateUser(login: String, password: String) {
        guard !isAuthenticating else { return }

        isAuthenticating = true

        // TODO: Проверка в бд, пока что имитация
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.user = AuthUser(email: login, password: password)
            self?.isAuthenticating = false
        }
    }
}
