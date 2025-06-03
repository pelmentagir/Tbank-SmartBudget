import UIKit

final class ProfileTableViewDataSource: NSObject, UITableViewDataSource {

    private let viewModel: ProfileViewModel

    private lazy var toggleThemeAction = UIAction { [weak self] sender in
        guard let switchControl = sender.sender as? UISwitch else { return }
        let isDarkMode = switchControl.isOn

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { $0.overrideUserInterfaceStyle = isDarkMode ? .dark : .light }
    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = viewModel.mainInfoItems[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = viewModel.settingsItems[indexPath.row]
            let themeSwitch = UISwitch()
            themeSwitch.addAction(toggleThemeAction, for: .valueChanged)
            cell.accessoryView = themeSwitch
        }
        return cell
    }
}
