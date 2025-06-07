protocol CategoryDistributionControllerProtocol: AnyObject {
    var presentBudgetPlanning: ((Category) -> Void)? { get set }
    
    func addCategoryInTag(category: Category)
}
