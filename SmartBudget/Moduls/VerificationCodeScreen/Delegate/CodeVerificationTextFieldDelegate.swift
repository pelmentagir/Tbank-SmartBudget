import UIKit

final class CodeVerificationTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private weak var delegate: CodeVerificationViewDelegate?
    private let codeFields: [CodeTextField]

    // MARK: Initialization
    init(delegate: CodeVerificationViewDelegate, codeFields: [CodeTextField]) {
        self.delegate = delegate
        self.codeFields = codeFields
        super.init()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? CodeTextField else { return true }

        if !string.isEmpty {
            field.text = string
            delegate?.didUpdateCode(at: field.tag, with: string)
            let nextTag = field.tag + 1
            if nextTag < codeFields.count {
                codeFields[nextTag].isEnabled = true
                codeFields[nextTag].becomeFirstResponder()
                field.isEnabled = false
            }
        } else {
            textField.text = ""
            delegate?.didUpdateCode(at: field.tag, with: "")
        }
        return false
    }
}
