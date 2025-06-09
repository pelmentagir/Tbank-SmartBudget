import Foundation

final class RegistrationViewModel {

    // MARK: Published Properties
    @Published private(set) var isRegistration: Bool = false
    @Published private(set) var user: AuthUser?
    @Published private(set) var error: Error?
    @Published private(set) var message: String?

    private let networkService: NetworkService = .shared
    private let tokenStorage: TokenStorage = .shared

    // MARK: Public Methods
    func isPasswordValid(with passwordText: String, confirmText: String) -> Bool {
        return passwordText == confirmText
    }

    func registrationUser(login: String, password: String) {
        guard !isRegistration else { return }

        isRegistration = true
        error = nil
        message = nil
        let request = AuthRequest(email: login, password: password)
        let endpoint = RegistrationEndpoint(request: request)

        networkService.request(endpoint, responseType: AuthResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let message = response.message {
                        self?.message = message
                        print(message)
                    }
                    if let accessToken = response.accessToken {
                        self?.tokenStorage.accessToken = accessToken
                        if let refreshToken = response.refreshToken {
                            self?.tokenStorage.refreshToken = refreshToken
                        }
                        self?.user = AuthUser(email: login, password: password)
                    }
                case .failure(let error):
                    self?.error = error
                }
                self?.isRegistration = false
            }
        }
    }
}
