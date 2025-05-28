import UIKit

final class CategoryBudgetDataSource: NSObject {
    private var dataSource: UITableViewDiffableDataSource<Int, CategorySpendingDTO>?
    private let tableView: UITableView

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, category in
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryBudgetTableViewCell.reuseIdentifier, for: indexPath) as! CategoryBudgetTableViewCell

            cell.configure(category: category)
            return cell
        })
    }

    func applySnapshot(categories: [CategorySpendingDTO], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategorySpendingDTO>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}
