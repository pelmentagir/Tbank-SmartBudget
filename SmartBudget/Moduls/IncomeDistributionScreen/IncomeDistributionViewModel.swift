import Foundation

final class IncomeDistributionViewModel {
    // MARK: Published Properties
    @Published private(set) var savingGoals: [SavingGoal] = [
        .init(id: 1, title: "Смартфон", image: nil, totalCost: 100000, accumulatedMoney: 56000, startDate: Date(), endDate: Date()),
        .init(id: 2, title: "Макбук", image: nil, totalCost: 100000, accumulatedMoney: 30000, startDate: Date(), endDate: Date())
    ]
    @Published var hideDistributionTable: Bool = true

    // MARK: Public Methods
    func distributeIncome(distribution: [Int: Int]) {
        for (goalId, amount) in distribution {
            if let index = savingGoals.firstIndex(where: { $0.id == goalId }) {
                savingGoals[index].accumulatedMoney += amount
            }
        }
    }
}
