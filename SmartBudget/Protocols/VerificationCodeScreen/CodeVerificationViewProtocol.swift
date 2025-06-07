import Foundation

protocol CodeVerificationViewProtocol: AnyObject {
    func updateTimerText(_ text: String)
    func updateEmailText(_ email: String)
    func updateField(at index: Int, text: String, isEnabled: Bool)
}
