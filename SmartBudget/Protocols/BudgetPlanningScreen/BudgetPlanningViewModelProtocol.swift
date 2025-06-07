import Combine

protocol BudgetPlanningViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var category: Category? { get }
    var percentage: Int { get }
    var selectedAmount: Int { get }
    var buttonState: ButtonState { get }

    var categoryPublisher: Published<Category?>.Publisher { get }
    var percentagePublisher: Published<Int>.Publisher { get }
    var selectedAmountPublisher: Published<Int>.Publisher { get }
    var buttonStatePublisher: Published<ButtonState>.Publisher { get }

    // MARK: Methods
    func calculateAmount(_ value: Float)
    func getFinalCategory() -> Category?
    func setCategory(_ newCategory: Category)
}

extension BudgetPlanningViewModel: BudgetPlanningViewModelProtocol {
    var categoryPublisher: Published<Category?>.Publisher { $category }
    var percentagePublisher: Published<Int>.Publisher { $percentage }
    var selectedAmountPublisher: Published<Int>.Publisher { $selectedAmount }
    var buttonStatePublisher: Published<ButtonState>.Publisher { $buttonState }
}
