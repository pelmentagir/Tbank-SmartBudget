import UIKit

final class ProfitTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    var updateFinalAmountLabel: ((String) -> Void)?
    weak var viewModel: AmountCollectionViewProtocol?

    // MARK: Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let textRange = Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: textRange, with: string)
        viewModel?.setNewAmount(updateText)
        return true
    }
}
