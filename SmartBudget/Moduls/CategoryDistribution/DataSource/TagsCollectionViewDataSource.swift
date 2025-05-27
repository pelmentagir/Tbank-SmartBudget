import UIKit

final class TagsCollectionViewDataSource: NSObject {

    // MARK: Properties
    private var dataSource: UICollectionViewDiffableDataSource<ViewSection, String>?
    private var collectionView: UICollectionView
    var viewModel: CategoryDistributionViewModel?

    init(collectionView: UICollectionView, viewModel: CategoryDistributionViewModel) {
        self.collectionView = collectionView
        self.viewModel = viewModel
        super.init()
        self.setupDataSource()
    }

    // MARK: Public Methods
    func applySnapshot(tags: [String], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ViewSection, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tags)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: Private Methods
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, tag in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as! TagCollectionViewCell
            cell.configureCell(text: tag) { [weak self] in
                guard let self else { return }
                viewModel?.removeTag(tag: tag)
                removeElement(tag, animated: true)
            }
            return cell
        })
    }

    private func removeElement(_ element: String, animated: Bool) {
        if var snapshot = dataSource?.snapshot() {
            snapshot.deleteItems([element])
            dataSource?.apply(snapshot, animatingDifferences: animated)
        }
    }
}
