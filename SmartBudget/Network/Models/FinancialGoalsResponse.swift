import Foundation

struct FinancialGoalsResponse: Decodable {
    let savingGoals: [SavingGoalResponse]
}

struct SavingGoalResponse: Decodable, Identifiable, Equatable {
    let title: String
    let imageUrl: String
    let totalCost: Int
    let accumulatedMoney: Int
    let id: Int
    let startDate: String
    let endDate: String
    
    var image: Data? = nil
    
    private enum CodingKeys: String, CodingKey {
        case id, title, imageUrl, totalCost, accumulatedMoney, startDate, endDate
    }
}
