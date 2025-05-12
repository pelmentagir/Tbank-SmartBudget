import UIKit
import Combine

final class AuthTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var emailTextField: ITextField?
    private var passwordTextField: ITextField?
    var onReturnKeyPressed: (() -> Void)?
    @Published var active = false

    // MARK: Public Methods
    func setEmailTextField(_ textField: ITextField) {
        textField.delegate = self
        emailTextField = textField
    }

    func setPasswordTextField(_ textField: ITextField) {
        textField.delegate = self
        passwordTextField = textField
    }

    // MARK: Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField?.becomeFirstResponder()
        } else if textField === passwordTextField && active {
            onReturnKeyPressed?()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let currentText = textField.text else { return false }
        let updatedText: String
        if let textRange = Range(range, in: currentText) {
            updatedText = currentText.replacingCharacters(in: textRange, with: string)
        } else {
            updatedText = string
        }
        textField.text = updatedText

        active = emailTextField!.isValid && passwordTextField!.isValid

        return false
    }
}
