import UIKit

final class CategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // MARK: Properties
    var viewModel: CategoryDistributionViewModel
    var categories: [Category]

    // MARK: Initialization
    init(viewModel: CategoryDistributionViewModel) {
        self.viewModel = viewModel
        self.categories = viewModel.obtainCategories()
        super.init()
    }

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.obtainCategories().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.configureCell(category: categories[indexPath.item])
        return cell
    }
}
