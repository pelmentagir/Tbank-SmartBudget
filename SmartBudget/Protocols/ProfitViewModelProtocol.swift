import Combine

protocol ProfitViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var currentProfit: Int { get }
    var selectedIndexInCollectionView: Int? { get }
    var valid: Bool { get }

    var currentProfitPublisher: Published<Int>.Publisher { get }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { get }
    var validPublisher: Published<Bool>.Publisher { get }

    // MARK: Methods
    func obtainAmount() -> [Int]
    func obtainCountAmount() -> Int
    func setNewCurrentProfit(_ profit: String)
    func getCurrentProfit() -> String
    func applyQuickProfitUpdate(index: Int)
}

extension ProfitViewModel: ProfitViewModelProtocol {
    var currentProfitPublisher: Published<Int>.Publisher { $currentProfit }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { $selectedIndexInCollectionView }
    var validPublisher: Published<Bool>.Publisher { $valid }
}
