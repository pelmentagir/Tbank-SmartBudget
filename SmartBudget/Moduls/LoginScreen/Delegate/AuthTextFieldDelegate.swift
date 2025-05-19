import UIKit
import Combine

final class AuthTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var emailTextField: ITextField?
    private var passwordTextField: ITextField?
    private var confirmPasswordTextField: ITextField?

    var checkPasswords: ((String) -> Void)?

    @Published var active = false
    private var confirmPasswordWorkItem: DispatchWorkItem?
    private let debounceDelay: TimeInterval = 0.5

    // MARK: Public Methods
    func setEmailTextField(_ textField: ITextField) {
        textField.delegate = self
        emailTextField = textField
    }

    func setPasswordTextField(_ textField: ITextField) {
        textField.delegate = self
        passwordTextField = textField
    }

    func setConfirmPasswordTextField(_ textField: ITextField) {
        textField.delegate = self
        confirmPasswordTextField = textField
    }

    // MARK: Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField!.becomeFirstResponder()
        } else if textField === passwordTextField {
            if confirmPasswordTextField != nil {
                confirmPasswordTextField!.becomeFirstResponder()
            } else {
                passwordTextField!.resignFirstResponder()
            }
        } else if textField === confirmPasswordTextField {
            confirmPasswordTextField!.resignFirstResponder()
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

        if textField === confirmPasswordTextField {
            confirmPasswordWorkItem?.cancel()

            let workItem = DispatchWorkItem { [weak self] in
                self?.checkPasswords?(textField.text!)
            }

            confirmPasswordWorkItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
        }

        if confirmPasswordTextField != nil {
            active = emailTextField!.isValid && passwordTextField!.isValid && passwordTextField!.text == confirmPasswordTextField!.text
        } else {
            active = emailTextField!.isValid && passwordTextField!.isValid
        }

        return false
    }
}
