import Foundation
import Combine

final class LoginViewModel {

    // MARK: Published Properties
    @Published private(set) var isPasswordVisible: Bool = false
    @Published private(set) var isAuthenticating: Bool = false
    @Published private(set) var user: AuthUser?

    @Published private(set) var error: Error?
    @Published private(set) var message: String?

    private let authService: AuthService = .shared
    private let tokenStorage: TokenStorage = .shared

    // MARK: Public Methods
    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    func authenticateUser(login: String, password: String) {
        guard !isAuthenticating else { return }

        isAuthenticating = true
        error = nil
        message = nil

        authService.login(email: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResponse):
                    if let message = authResponse.message {
                        self?.message = message
                        print(message)
                    }
                    if authResponse.accessToken != nil {
                        self?.user = AuthUser(email: login, password: password)
                    }
                case .failure(let error):
                    print(error)
                    self?.error = error
                }
                self?.isAuthenticating = false
            }
        }
    }
}
