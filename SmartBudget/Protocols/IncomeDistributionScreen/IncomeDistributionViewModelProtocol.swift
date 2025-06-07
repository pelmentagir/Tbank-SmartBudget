import Combine

protocol IncomeDistributionViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var savingGoals: [SavingGoal] { get }
    var hideDistributionTable: Bool { get set }
    
    var savingGoalsPublisher: Published<[SavingGoal]>.Publisher { get }
    var hideDistributionTablePublisher: Published<Bool>.Publisher { get }
    
    // MARK: Public Methods
    func distributeIncome(distribution: [Int: Int])
}

extension IncomeDistributionViewModel: IncomeDistributionViewModelProtocol {
    var savingGoalsPublisher: Published<[SavingGoal]>.Publisher { $savingGoals }
    var hideDistributionTablePublisher: Published<Bool>.Publisher { $hideDistributionTable }
}
