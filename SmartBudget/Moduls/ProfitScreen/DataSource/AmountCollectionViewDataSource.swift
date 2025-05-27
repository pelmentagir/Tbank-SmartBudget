import UIKit

final class AmountCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // MARK: Properties
    private let viewModel: ProfitViewModel
    private let dataSource: [Int]

    // MARK: Initialization
    init(viewModel: ProfitViewModel) {
        self.viewModel = viewModel
        self.dataSource = viewModel.obtainAmount()
    }

    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.obtainCountAmount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmountCollectionViewCell.reuseIdentifier, for: indexPath) as! AmountCollectionViewCell
        cell.configureCell(amount: dataSource[indexPath.item])
        return cell
    }
}
