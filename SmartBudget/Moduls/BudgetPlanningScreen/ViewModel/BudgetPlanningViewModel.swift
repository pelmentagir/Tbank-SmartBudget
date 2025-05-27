import UIKit
import Combine

final class BudgetPlanningViewModel {

    // MARK: Published Properties
    @Published private(set) var category: Category?
    @Published private(set) var percentage: Int = 0
    @Published private(set) var selectedAmount: Int = 0
    @Published private(set) var buttonState: ButtonState = .disabled

    // MARK: Properties
    private var totalBudget: Int = 10000

    // MARK: Initialization
    init(category: Category) {
        if category.name != "Создать" {
            self.category = category
        }
    }

    // MARK: Public Methods
    func calculateAmount(_ value: Float) {
        percentage = Int(value * 100)
        selectedAmount = Int(Float(totalBudget) * (value))

        buttonState = percentage > 0 ? .normal : .disabled
    }

    func getFinalCategory() -> Category? {
        guard let category else { return nil }
        var finalCategory = category
        finalCategory.amount = selectedAmount
        finalCategory.percentage = percentage
        return finalCategory
    }

    func setCategory(_ newCategory: Category) {
        category = newCategory
    }
}
