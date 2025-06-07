import Combine

protocol ProfitViewModelProtocol: AnyObject, AmountCollectionViewProtocol {

    // MARK: Published Properties
    var currentProfit: Int { get }
    var selectedIndexInCollectionView: Int? { get }
    var valid: Bool { get }
    var amount: [Int] { get }

    var currentProfitPublisher: Published<Int>.Publisher { get }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { get }
    var validPublisher: Published<Bool>.Publisher { get }
    var amountPublished: Published<[Int]>.Publisher { get }

    // MARK: Methods
    func getCurrentProfit() -> String
}

extension ProfitViewModel: ProfitViewModelProtocol {
    var currentProfitPublisher: Published<Int>.Publisher { $currentProfit }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { $selectedIndexInCollectionView }
    var validPublisher: Published<Bool>.Publisher { $valid }
    var amountPublished: Published<[Int]>.Publisher { $amount }
}
