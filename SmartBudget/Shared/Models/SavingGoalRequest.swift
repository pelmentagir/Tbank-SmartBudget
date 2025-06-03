import UIKit

struct SavingGoalRequest {
    var title: String = ""
    var image: UIImage?
    var totalCost: Int = 0
    var accumulatedMoney: Int = 0
    let startDate: Date = Date()
    var endDate: Date?
}
