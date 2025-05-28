import UIKit

final class FullNameTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var nameTextField: ITextField?
    private var lastNameTextField: ITextField?

    weak var viewModel: CreateProfileViewModelProtocol?

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
}
