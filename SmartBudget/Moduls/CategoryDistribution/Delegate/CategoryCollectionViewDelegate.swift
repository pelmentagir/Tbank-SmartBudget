import UIKit

final class CategoryCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    // MARK: Properties
    weak var viewModel: CategoryDistributionViewModel?

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectedCategoryAtIndex(indexPath.item)
    }
}
