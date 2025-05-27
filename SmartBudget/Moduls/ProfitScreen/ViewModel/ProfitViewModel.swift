import Foundation
import Combine

final class ProfitViewModel {

    // MARK: Published Properties
    @Published private(set) var currentProfit = 0
    @Published private(set) var selectedIndexInCollectionView: Int?
    @Published private(set) var valid = false

    // MARK: Properties
    private let amount: [Int] = [10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 65000, 70000, 75000, 80000, 85000, 90000, 95000, 100000]

    // MARK: Public Methods
    func obtainAmount() -> [Int] { amount }

    func obtainCountAmount() -> Int { amount.count }

    func setNewCurrentProfit(_ profit: String) {
        selectedIndexInCollectionView = nil
        if let profitValue = Int(profit) {
            currentProfit = profitValue
            valid = true
        } else {
            currentProfit = 0
            valid = false
        }
    }

    func getCurrentProfit() -> String {
        return String(currentProfit)
    }

    func applyQuickProfitUpdate(index: Int) {
        if let currentIndex = selectedIndexInCollectionView, currentIndex == index {
            currentProfit = 0
            valid = false
            selectedIndexInCollectionView = nil
            return
        }
        currentProfit = amount[index]
        selectedIndexInCollectionView = index
        valid = true
    }
}
