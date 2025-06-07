import Combine

protocol RegistrationViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var isRegistration: Bool { get }
    var user: AuthUser? { get }

    var isRegistrationPublisher: Published<Bool>.Publisher { get }
    var userPublisher: Published<AuthUser?>.Publisher { get }

    // MARK: Methods
    func isPasswordValid(with passwordText: String, confirmText: String) -> Bool
    func registrationUser(login: String, password: String)
}

extension RegistrationViewModel: RegistrationViewModelProtocol {
    var isRegistrationPublisher: Published<Bool>.Publisher { $isRegistration }
    var userPublisher: Published<AuthUser?>.Publisher { $user }
}
