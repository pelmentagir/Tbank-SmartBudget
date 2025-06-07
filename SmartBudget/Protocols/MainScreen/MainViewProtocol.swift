import Foundation

protocol MainViewProtocol: AnyObject {
    func setSpentIncome(spent: Int)
    func setLeftIncome(left: Int)
    func configurePie(with items: [CategorySpending])
}
