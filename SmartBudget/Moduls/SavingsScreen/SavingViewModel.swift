import Foundation

final class SavingViewModel {

    // MARK: Published Properties
    @Published var savingGoals: [SavingGoal] = [

    ]

    private var networkService: NetworkService = .shared

    init() {
        fetchSavingGoals()
    }

    // MARK: Public Methods
    func replenishCartainSavingGoal(_ savingGoal: SavingGoal) {
        if let index = savingGoals.firstIndex(where: {$0.id == savingGoal.id}) {
            savingGoals[index] = savingGoal
        }
    }

    func fetchSavingGoals() {
        let endpoint = GetFinancialGoalsEndpoint()
        networkService.request(endpoint, responseType: FinancialGoalsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let goals = response.savingGoals.compactMap { goal -> SavingGoal? in
                    return SavingGoal(
                        id: goal.id,
                        title: goal.name,
                        image: nil,
                        totalCost: goal.amount,
                        accumulatedMoney: goal.progress,
                        startDate: goal.startDate.date,
                        endDate: goal.endDate.date
                    )
                }

                DispatchQueue.main.async {
                    self?.savingGoals = goals
                }

            case .failure(let error):
                print("Ошибка при загрузке целей: \(error)")
            }
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
