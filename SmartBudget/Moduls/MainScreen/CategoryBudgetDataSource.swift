import UIKit

final class CategoryBudgetDataSource: NSObject {
    
    // MARK: Properties
    private var dataSource: UITableViewDiffableDataSource<Int, CategorySpending>?
    private let tableView: UITableView

    // MARK: Intialization
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
    }
    
    // MARK: Public Methods
    func applySnapshot(categories: [CategorySpending], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategorySpending>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: Private Methods
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, category in
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryBudgetTableViewCell.reuseIdentifier, for: indexPath) as! CategoryBudgetTableViewCell

            cell.configure(category: category)
            return cell
        })
    }
}
