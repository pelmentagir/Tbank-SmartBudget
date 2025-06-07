protocol BudgetPlanningViewProtocol: AnyObject {
    func hideViews(_ state: Bool)
    func setupView(category: Category)
    func setAmount(_ amount: Int)
    func setPercentage(_ percentage: Int)
}
