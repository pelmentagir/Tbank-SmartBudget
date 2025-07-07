import Combine

protocol ProfitViewModelProtocol: AnyObject, AmountCollectionViewProtocol {

    // MARK: Published Properties
    var currentProfit: Int { get }
    var selectedIndexInCollectionView: Int? { get }
    var valid: Bool { get }
    var salaryDay: Int? { get }
    var amount: [Int] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var success: Bool { get }
    
    var currentProfitPublisher: Published<Int>.Publisher { get }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { get }
    var validPublisher: Published<Bool>.Publisher { get }
    var amountPublished: Published<[Int]>.Publisher { get }
    var salaryDayPublisher: Published<Int?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var successPublisher: Published<Bool>.Publisher { get }

    // MARK: Methods
    func getCurrentProfit() -> String
    func setNewAmount(_ amount: String)
    func setSalaryDay(_ day: Int)
    func applyQuickAmountUpdate(index: Int)
    func submitProfitAndSalaryDay()
    func updateValidity()
}

extension ProfitViewModel: ProfitViewModelProtocol {
    var currentProfitPublisher: Published<Int>.Publisher { $currentProfit }
    var selectedIndexInCollectionViewPublisher: Published<Int?>.Publisher { $selectedIndexInCollectionView }
    var validPublisher: Published<Bool>.Publisher { $valid }
    var amountPublished: Published<[Int]>.Publisher { $amount }
    var salaryDayPublisher: Published<Int?>.Publisher { $salaryDay }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var successPublisher: Published<Bool>.Publisher { $success }
}
