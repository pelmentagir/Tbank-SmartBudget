import UIKit

final class SearchTableViewDataSource: NSObject {

    // MARK: Properties
    private var dataSource: UITableViewDiffableDataSource<ViewSection, Category>?
    private let tableView: UITableView

    // MARK: Initialization
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.setupDataSource()
    }

    // MARK: Public Methods
    func applySnapshot(categories: [Category], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ViewSection, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: Private Methods
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, category in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
            cell.configureCell(category: category)
            return cell
        })
    }
}
