import UIKit

final class AmountCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    // MARK: Properties
    weak var viewModel: AmountCollectionViewProtocol?

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        viewModel?.applyQuickAmountUpdate(index: indexPath.item)
    }
}
