import Foundation
import Combine

final class ReplenishViewModel: NSObject {

    // MARK: Published Properties
    @Published private(set) var replenishmentAmount = 0
    @Published private(set) var selectedIndexInCollectionView: Int?
    @Published private(set) var valid = false
    @Published private(set) var savingGoal: SavingGoal
    @Published private(set) var amount: [Int] = [500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000]

    private let networkService: NetworkService = .shared

    // MARK: Initialization
    init(savingGoal: SavingGoal) {
        self.savingGoal = savingGoal
        super.init()
    }

    // MARK: Public Methods
    func setNewAmount(_ profit: String) {
        selectedIndexInCollectionView = nil
        if let profitValue = Int(profit) {
            replenishmentAmount = profitValue
            valid = true
        } else {
            replenishmentAmount = 0
            valid = false
        }
    }

    func getCurrentReplenishmentAmount() -> String {
        return String(replenishmentAmount)
    }

    func applyQuickAmountUpdate(index: Int) {
        if let currentIndex = selectedIndexInCollectionView, currentIndex == index {
            replenishmentAmount = 0
            valid = false
            selectedIndexInCollectionView = nil
            return
        }
        replenishmentAmount = amount[index]
        selectedIndexInCollectionView = index
        valid = true
    }

    func applyReplenishmentAmountOnSavingGoal() {
        savingGoal.accumulatedMoney += replenishmentAmount
    }
    
    func updateGoalProgress(completion: @escaping (Result<Void, Error>) -> Void) {
        let updateData = FinancialGoalProgressUpdate(
            cost: Double(replenishmentAmount),
            goalId: savingGoal.id
        )

        let endpoint = UpdateFinancialGoalProgressEndpoint(requestData: updateData)

        networkService.requestWithEmptyResponse(endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.applyReplenishmentAmountOnSavingGoal()
                    completion(.success(()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
