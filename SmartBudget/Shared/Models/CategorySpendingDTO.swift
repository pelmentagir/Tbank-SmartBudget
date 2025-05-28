import Foundation

struct CategorySpendingDTO: Hashable {
    let categoryName: String
    let spentMoney: Int
    let leftMoney: Int
    let percent: Int
}
