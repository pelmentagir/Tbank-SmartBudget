import UIKit

final class SalaryDayTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Properties
    private var salaryDayTextField: ITextField?
    private var selectedDay: Int?
    weak var viewModel: ProfitViewModelProtocol?

    // MARK: Public Methods
    func setSalaryDayTextField(_ textField: ITextField) {
        textField.delegate = self
        salaryDayTextField = textField
        setupDayPicker()
    }

    func getSelectedDay() -> Int? {
        return selectedDay
    }

    // MARK: Private Methods
    private func setupDayPicker() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        salaryDayTextField?.inputView = pickerView
        salaryDayTextField?.inputAccessoryView = createToolbar()
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
    @objc private func doneButtonTapped() {
        salaryDayTextField?.resignFirstResponder()
    }

    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension SalaryDayTextFieldDelegate: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 29
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDay = row + 1
        salaryDayTextField?.text = "\(row + 1) день"
        viewModel?.setSalaryDay(row + 1)
    }
}
