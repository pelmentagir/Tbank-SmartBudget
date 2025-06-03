import Combine

protocol ReplenishViewModelProtocol: AnyObject, AmountCollectionViewProtocol {

    // MARK: Published Properties
    var replenishmentAmount: Int { get }
    var selectedIndexInCollectionView: Int? { get }
    var valid: Bool { get }
    var amount: [Int] { get }
    var savingGoal: SavingGoal { get }

    var replenishmentAmountPublisher: Published<Int>.Publisher { get }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { get }
    var validPublisher: Published<Bool>.Publisher { get }
    var amountPublished: Published<[Int]>.Publisher { get }
    var savingGoalPublished: Published<SavingGoal>.Publisher { get }

    // MARK: Methods
    func getCurrentReplenishmentAmount() -> String
    func applyReplenishmentAmountOnSavingGoal()
}

extension ReplenishViewModel: ReplenishViewModelProtocol {
    
    var replenishmentAmountPublisher: Published<Int>.Publisher { $replenishmentAmount }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { $selectedIndexInCollectionView }
    var validPublisher: Published<Bool>.Publisher { $valid }
    var amountPublished: Published<[Int]>.Publisher { $amount }
    var savingGoalPublished: Published<SavingGoal>.Publisher { $savingGoal }
}
