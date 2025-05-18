import UIKit

class FullNameTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var nameTextField: ITextField?
    private var lastNameTextField: ITextField?
    private let debounceDelay: TimeInterval = 0.5

    weak var viewModel: CreateProfileViewModel?

    // MARK: Public Methods
    func setNameTextField(_ textField: ITextField) {
        textField.delegate = self
        nameTextField = textField
    }

    func setLastNameTextField(_ textField: ITextField) {
        textField.delegate = self
        lastNameTextField = textField
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel?.hideClue()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === nameTextField {
            lastNameTextField?.becomeFirstResponder()
        } else if textField === lastNameTextField {
            lastNameTextField?.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
