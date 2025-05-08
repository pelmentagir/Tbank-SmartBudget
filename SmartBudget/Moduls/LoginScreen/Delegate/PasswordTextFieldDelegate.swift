import UIKit

final class PasswordTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let currentText = textField.text else { return false }
        let updatedText: String
        if let textRange = Range(range, in: currentText) {
            updatedText = currentText.replacingCharacters(in: textRange, with: string)
        } else {
            updatedText = string
        }
        textField.text = updatedText
        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: textField)
        return false

    }
}
