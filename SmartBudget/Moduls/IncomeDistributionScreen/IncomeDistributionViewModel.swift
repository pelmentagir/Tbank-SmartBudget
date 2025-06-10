import Foundation

final class IncomeDistributionViewModel {
    // MARK: Published Properties
    @Published private(set) var savingGoals: [SavingGoal] = [
        
    ]
    @Published var hideDistributionTable: Bool = true

    // MARK: Public Methods
    func distributeIncome(distribution: [Int: Int]) {
        for (goalId, amount) in distribution {
            if let index = savingGoals.firstIndex(where: { $0.id == goalId }) {
                //savingGoals[index].accumulatedMoney += amount
            }
        }
    }
}
