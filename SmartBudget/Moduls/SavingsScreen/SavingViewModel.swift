import Foundation

final class SavingViewModel {

    // MARK: Published Properties
    @Published var savingGoals: [SavingGoal] = [
        .init(id: 1, title: "Смартфон", image: nil, totalCost: 100000, accumulatedMoney: 56000, startDate: Date(), endDate: Date()),
        .init(id: 2, title: "Смартфон", image: nil, totalCost: 100000, accumulatedMoney: 30000, startDate: Date(), endDate: Date())
    ]

    // MARK: Public Methods
    func replenishCartainSavingGoal(_ savingGoal: SavingGoal) {
        if let index = savingGoals.firstIndex(where: {$0.id == savingGoal.id}) {
            savingGoals[index] = savingGoal
        }
    }

    func calculateMonthlySaving(for goal: SavingGoal, currentDate: Date = Date()) -> Int {

        if currentDate >= goal.endDate {
            return 0
        }

        let remainingAmount = goal.totalCost - goal.accumulatedMoney

        if remainingAmount <= 0 {
            return 0
        }

        let calendar = Calendar.current
        let totalMonths = calendar.dateComponents([.month], from: goal.startDate, to: goal.endDate).month ?? 0

        let monthsPassed = calendar.dateComponents([.month], from: goal.startDate, to: currentDate).month ?? 0

        let monthsRemaining = totalMonths - monthsPassed

        if monthsRemaining <= 0 {
            return remainingAmount
        }

        let monthlySaving = remainingAmount / monthsRemaining

        return monthlySaving
    }
}
