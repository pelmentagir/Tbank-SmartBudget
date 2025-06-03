import Combine

protocol SecondAddingGoalViewModelProtocol: AnyObject, AmountCollectionViewProtocol {

    // MARK: Published Properties
    var currentTotalSum: Int { get }
    var selectedIndexInCollectionView: Int? { get }
    var valid: Bool { get }
    var amount: [Int] { get }
    var currentCapitalMoney: Int { get }

    var currentProfitPublisher: Published<Int>.Publisher { get }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { get }
    var validPublisher: Published<Bool>.Publisher { get }
    var amountPublished: Published<[Int]>.Publisher { get }

    // MARK: Methods
    func getCurrentTotalSum() -> String
    func setCapital(money: String)
}

extension SecondScreenAddingGoalViewModel: SecondAddingGoalViewModelProtocol {
    var currentProfitPublisher: Published<Int>.Publisher { $currentTotalSum }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { $selectedIndexInCollectionView }
    var validPublisher: Published<Bool>.Publisher { $valid }
    var amountPublished: Published<[Int]>.Publisher { $amount }
}
