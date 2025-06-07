import UIKit

final class CategoryDistributionTableDataSource: NSObject {

    // MARK: Properties
    private var dataSource: UITableViewDiffableDataSource<String, SavingGoal>?
    private let tableView: UITableView

    // MARK: Initialization
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
    }

    // MARK: Public Methods
    func applySnapshot(savingGoals: [SavingGoal]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, SavingGoal>()

        for goal in savingGoals {
            snapshot.appendSections([goal.title])
            snapshot.appendItems([goal], toSection: goal.title)
        }

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    func getDistributionValues() -> [Int: Int] {
        var distribution: [Int: Int] = [:]

        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? CategoryDistributionTableViewCell,
                   let goal = dataSource?.itemIdentifier(for: IndexPath(row: row, section: section)) {
                    let amount = Int(cell.textField.getField().text ?? "0") ?? 0
                    distribution[goal.id] = amount
                }
            }
        }
        return distribution
    }

    // MARK: Private Methods
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, savingGoal in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryDistributionTableViewCell.reuseIdentifier,
                for: indexPath) as? CategoryDistributionTableViewCell else { return UITableViewCell() }

            cell.configureCell(savingGoal)
            return cell
        }
    }
}
