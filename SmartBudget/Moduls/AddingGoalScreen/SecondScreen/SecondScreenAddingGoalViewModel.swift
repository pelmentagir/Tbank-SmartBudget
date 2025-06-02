import Foundation
import Combine

final class SecondScreenAddingGoalViewModel: NSObject {

    // MARK: Published Properties
    @Published private(set) var currentTotalSum = 0
    @Published private(set) var selectedIndexInCollectionView: Int?
    @Published private(set) var valid = false
    @Published private(set) var amount: [Int] = [10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 65000, 70000, 75000, 80000, 85000, 90000, 95000, 100000]

    // MARK: Properties
    private(set) var currentCapitalMoney = 0

    // MARK: Public Methods
    func setCapital(money: String) {
        currentCapitalMoney = Int(money) ?? 0
    }

    func setNewAmount(_ amount: String) {
        selectedIndexInCollectionView = nil
        if let profitValue = Int(amount) {
            currentTotalSum = profitValue
            valid = true
        } else {
            currentTotalSum = 0
            valid = false
        }
    }

    func getCurrentTotalSum() -> String {
        return String(currentTotalSum)
    }

    func applyQuickAmountUpdate(index: Int) {
        if let currentIndex = selectedIndexInCollectionView, currentIndex == index {
            currentTotalSum = 0
            valid = false
            selectedIndexInCollectionView = nil
            return
        }
        currentTotalSum = amount[index]
        selectedIndexInCollectionView = index
        valid = true
    }
}
