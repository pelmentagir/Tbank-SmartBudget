import UIKit

final class CategoryCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    // MARK: Properties
    weak var viewModel: CategoryDistributionViewModelProtocol?

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectedCategoryAtIndex(indexPath.item)
    }
}
