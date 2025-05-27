import UIKit

final class AmountCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    // MARK: Properties
    weak var viewModel: ProfitViewModel?

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        viewModel?.applyQuickProfitUpdate(index: indexPath.item)
    }
}
