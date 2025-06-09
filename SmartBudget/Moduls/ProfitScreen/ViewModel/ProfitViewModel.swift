import Foundation
import Combine

final class ProfitViewModel: NSObject {

    // MARK: Published Properties
    @Published private(set) var currentProfit = 0
    @Published private(set) var selectedIndexInCollectionView: Int?
    @Published private(set) var valid = false
    @Published private(set) var salaryDay: Int?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var success: Bool = false

    // MARK: Properties
    @Published private(set) var amount: [Int] = [10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 65000, 70000, 75000, 80000, 85000, 90000, 95000, 100000]

    // MARK: Public Methods
    func setNewAmount(_ amount: String) {
        selectedIndexInCollectionView = nil
        if let profitValue = Int(amount) {
            currentProfit = profitValue
            updateValidity()
        } else {
            currentProfit = 0
            valid = false
        }
    }

    func setSalaryDay(_ day: Int) {
        salaryDay = day
        updateValidity()
    }

    func updateValidity() {
        valid = currentProfit > 0 && salaryDay != nil
    }

    func getCurrentProfit() -> String {
        return String(currentProfit)
    }

    func applyQuickAmountUpdate(index: Int) {
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

    func submitProfitAndSalaryDay() {
        guard valid, let day = salaryDay else {
            return
        }

        isLoading = true
        errorMessage = nil

        let endpoint = SetIncomeEndpoint(income: currentProfit, dayOfSalary: day)

        NetworkService.shared.requestWithEmptyResponse(endpoint) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.success = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.success = false
                }
            }
        }
    }
}
