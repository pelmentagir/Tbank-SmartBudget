import UIKit

final class SavingTargetTableViewDataSource: NSObject {

    // MARK: Properties
    var dataSource: UITableViewDiffableDataSource<ViewSection, SavingGoal>?
    let tableView: UITableView
    var onReplenishTapped: ((SavingGoal) -> Void)?
    weak var viewModel: SavingViewModel?

    // MARK: Initialization
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
    }

    // MARK: Public Methods
    func applySnapshot(items: [SavingGoal], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ViewSection, SavingGoal>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: Private Methods
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, savingGoal in
            let cell = tableView.dequeueReusableCell(withIdentifier: SavingTargetTableViewCell.reuseIdentifier, for: indexPath) as! SavingTargetTableViewCell
            let monthlySaving = self.viewModel?.calculateMonthlySaving(for: savingGoal)
            cell.configureCell(item: savingGoal, monthlySaving: monthlySaving ?? 0) { [weak self] in
                guard let self else { return }
                onReplenishTapped?(savingGoal)
            }
            return cell
        })
    }
}
