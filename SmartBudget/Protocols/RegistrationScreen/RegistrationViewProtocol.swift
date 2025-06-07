import Foundation

protocol RegistrationViewProtocol: AnyObject {
    func updateLayout(keyboardRect: CGRect)
    func visableClue(_ state: Bool)
}
