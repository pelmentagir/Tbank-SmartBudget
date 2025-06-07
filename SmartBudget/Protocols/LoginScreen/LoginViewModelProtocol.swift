import Combine

protocol LoginViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var isPasswordVisible: Bool { get }
    var isAuthenticating: Bool { get }
    var user: AuthUser? { get }

    var isPasswordVisiblePublisher: Published<Bool>.Publisher { get }
    var isAuthenticatingPublisher: Published<Bool>.Publisher { get }
    var userPublisher: Published<AuthUser?>.Publisher { get }

    // MARK: Methods
    func togglePasswordVisibility()
    func authenticateUser(login: String, password: String)
}

extension LoginViewModel: LoginViewModelProtocol {
    var isPasswordVisiblePublisher: Published<Bool>.Publisher { $isPasswordVisible }
    var isAuthenticatingPublisher: Published<Bool>.Publisher { $isAuthenticating }
    var userPublisher: Published<AuthUser?>.Publisher { $user }
}
