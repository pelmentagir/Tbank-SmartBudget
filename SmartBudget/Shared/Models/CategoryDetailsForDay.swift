import Foundation

struct CategoryDetailsForDay: Hashable {
    let id = UUID()
    let categoryName: String
    let spendMoney: Double
}
