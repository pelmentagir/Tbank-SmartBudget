import UIKit

final class OperationTableViewDataSource: NSObject {

    // MARK: Properties
    private var dataSource: UITableViewDiffableDataSource<String, CategoryDetailsForDay>?
    private let tableView: UITableView

    // MARK: Initialization
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
    }

    // MARK: Public Methods
    func applySnapshot(with days: [DayInfo]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, CategoryDetailsForDay>()

        let reversedDays = days.reversed()

        for (index, day) in reversedDays.enumerated() {
            guard let date = day.date else {
                continue
            }

            let sectionTitle = self.formatDate(date)

            if !snapshot.sectionIdentifiers.contains(sectionTitle) {
                snapshot.appendSections([sectionTitle])
            }

            snapshot.appendItems(day.categoryDetailsForDay, toSection: sectionTitle)
        }

        print("Итоговый snapshot: \(snapshot.sectionIdentifiers)")
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Private Methods
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: LocaleIdentifier.ru.identifier)
        formatter.dateFormat = "d MMMM"
        print(formatter.string(from: date))
        return formatter.string(from: date)
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, categoryDetail in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OperationTableViewCell.reuseIdentifier, for: indexPath) as? OperationTableViewCell else { return UITableViewCell() }
            cell.configureCell(category: categoryDetail)
            return cell
        })
    }
}
