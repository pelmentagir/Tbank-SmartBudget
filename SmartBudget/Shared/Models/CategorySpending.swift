import Foundation

struct CategorySpending: Decodable, Hashable {
    let categoryName: String
    let spentMoney: Int
    let leftMoney: Int
    let percent: Int
}
