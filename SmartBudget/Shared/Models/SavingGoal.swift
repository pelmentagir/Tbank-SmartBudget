import UIKit

struct SavingGoal: Hashable {
    let id: Int
    let title: String
    var image: UIImage?
    let totalCost: Int
    var accumulatedMoney: Int
    let startDate: Date
    let endDate: Date
}
