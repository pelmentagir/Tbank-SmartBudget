import UIKit

final class ProfileTableViewDataSource: NSObject, UITableViewDataSource {

    // MARK: Properties
    private let viewModel: ProfileViewModel

    private lazy var toggleThemeAction = UIAction { [weak self] sender in
        guard let switchControl = sender.sender as? UISwitch else { return }
        let isDarkMode = switchControl.isOn

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { $0.overrideUserInterfaceStyle = isDarkMode ? .dark : .light }
    }

    // MARK: Initialization
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Methods Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.mainInfoItems.count : viewModel.settingsItems.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }

        if indexPath.section == 0 {
            cell.configure(title: viewModel.mainInfoItems[indexPath.row], value: viewModel.getInfoUserAtIndex(index: indexPath.row))
        } else {
            let isThemeRow = indexPath.row == 0
            cell.configure(
                title: viewModel.settingsItems[indexPath.row],
                value: "",
                showToggle: isThemeRow,
                toggleAction: isThemeRow ? toggleThemeAction : nil
            )
        }

        return cell
    }
}
