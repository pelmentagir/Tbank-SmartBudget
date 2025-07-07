import Combine
import UserNotifications

protocol MainViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var chartItems: [CategorySpending] { get set }
    var spentIncome: Int { get set }
    var leftIncome: Int { get set }
    
    var chartItemsPublisher: Published<[CategorySpending]>.Publisher { get }
    var spentIncomePublisher: Published<Int>.Publisher { get }
    var leftIncomePublisher: Published<Int>.Publisher { get }
    
    func mockPush(request: UNNotificationRequest)
}

extension MainViewModel: MainViewModelProtocol {
    var chartItemsPublisher: Published<[CategorySpending]>.Publisher { $chartItems }
    var spentIncomePublisher: Published<Int>.Publisher { $spentIncome }
    var leftIncomePublisher: Published<Int>.Publisher { $leftIncome }
}
