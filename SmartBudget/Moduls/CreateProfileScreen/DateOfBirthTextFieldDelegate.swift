import UIKit

final class DateOfBirthTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var dateOfBirthTextField: ITextField?
    private var selectedDate: Date?

    weak var viewModel: CreateProfileViewModelProtocol?

    // MARK: Public Methods
    func setDateOfBirthTextField(_ textField: ITextField) {
        textField.delegate = self
        dateOfBirthTextField = textField
        setupDatePicker()
    }

    func getSelectedDate() -> Date? {
        return selectedDate
    }

    // MARK: Private Methods
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        dateOfBirthTextField?.inputView = datePicker
        dateOfBirthTextField?.inputAccessoryView = createToolbar()
    }

    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }

    // MARK: Actions
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: LocaleIdentifier.ru.identifier)
        dateOfBirthTextField?.text = formatter.string(from: sender.date)
        selectedDate = sender.date
    }

    @objc private func doneButtonTapped() {
        dateOfBirthTextField?.resignFirstResponder()
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel?.hideClue()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
