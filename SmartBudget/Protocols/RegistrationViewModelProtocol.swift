import Combine

protocol RegistrationViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var isRegistration: Bool { get }
    var user: User? { get }

    var isRegistrationPublisher: Published<Bool>.Publisher { get }
    var userPublisher: Published<User?>.Publisher { get }

    // MARK: Methods
    func isPasswordValid(with passwordText: String, confirmText: String) -> Bool
    func registrationUser(login: String, password: String)
}

extension RegistrationViewModel: RegistrationViewModelProtocol {
    var isRegistrationPublisher: Published<Bool>.Publisher { $isRegistration }
    var userPublisher: Published<User?>.Publisher { $user }
}
