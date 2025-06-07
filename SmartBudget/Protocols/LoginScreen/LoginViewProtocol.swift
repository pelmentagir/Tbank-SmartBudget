import Foundation

protocol LoginViewProtocol: AnyObject {
    func updateLayout(keyboardRect: CGRect)
    func updatePasswordVisibility(_ isVisible: Bool)
}
