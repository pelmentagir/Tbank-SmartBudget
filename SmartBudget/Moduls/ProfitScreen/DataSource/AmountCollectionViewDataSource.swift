import UIKit

final class AmountCollectionViewDataSource: NSObject {

    // MARK: Properties
    private var dataSource: UICollectionViewDiffableDataSource<ViewSection, Int>?
    private let collectionView: UICollectionView

    // MARK: Initialization
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupDataSource()
    }

    func applySnapshot(items: [Int], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ViewSection, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, amount in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmountCollectionViewCell.reuseIdentifier, for: indexPath) as! AmountCollectionViewCell
            cell.configureCell(amount: amount)
            
            return cell
        })
    }
}
