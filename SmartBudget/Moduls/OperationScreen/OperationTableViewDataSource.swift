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

        for day in days {
            let sectionTitle = self.formatDate(day.day)
            snapshot.appendSections([sectionTitle])
            snapshot.appendItems(day.categoryDetailsForDay, toSection: sectionTitle)
        }

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    // MARK: Private Methods
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
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
