import UIKit

class AmountCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var viewModel: ProfitViewModel
    private var dataSource: [Int]

    init(viewModel: ProfitViewModel) {
        self.viewModel = viewModel
        self.dataSource = viewModel.obtainAmount()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.obtainCountAmount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmountCollectionViewCell.reuseIdentifier, for: indexPath) as! AmountCollectionViewCell
        cell.configureCell(amount: dataSource[indexPath.item])
        return cell
    }
}
