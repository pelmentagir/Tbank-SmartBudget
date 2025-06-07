import UIKit

private extension String {
    static let nameTextFieldPlaceholder = "Введите имя"
    static let lastNameTextFieldPlaceholder = "Введите фамилию"
    static let salaryDayTextFieldPlaceholder = "День зарплаты"
    static let salaryAmountTextFieldPlaceholder = "Сумма зарплаты"
}

final class EdittingProfileTableViewDataSource: NSObject, UITableViewDataSource {

    // MARK: Properties
    private let viewModel: EdittingProfileViewModelProtocol

    // MARK: Initialization
    init(viewModel: EdittingProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditCell.reuseIdentifier, for: indexPath) as? ProfileEditCell else {
            return UITableViewCell()
        }

        let item = viewModel.items[indexPath.row]
        var placeholder = ""
        var text = ""
        var keyboardType: UIKeyboardType = .default

        switch item {
        case "Имя":
            placeholder = .nameTextFieldPlaceholder
            text = viewModel.user.name
        case "Фамилия":
            placeholder = .lastNameTextFieldPlaceholder
            text = viewModel.user.lastName
        case "День зарплаты":
            placeholder = .salaryDayTextFieldPlaceholder
            text = "\(viewModel.user.dayOfSalary)"
            keyboardType = .numberPad
        case "Сумма зарплаты":
            placeholder = .salaryAmountTextFieldPlaceholder
            text = "\(viewModel.user.income)"
            keyboardType = .numberPad
        default:
            break
        }

        cell.configure(title: item, placeholder: placeholder, text: text, keyboardType: keyboardType)
        return cell
    }
}
