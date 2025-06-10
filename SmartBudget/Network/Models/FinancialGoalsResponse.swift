import Foundation

struct FinancialGoalsResponse: Codable {
    let savingGoals: [SavingGoalResponse]
}

struct SavingGoalResponse: Codable, Identifiable, Equatable {
    let name: String
    let imageUrl: String
    let amount: Int
    let progress: Int
    let id: Int
    let startDate: CustomDate
    let endDate: CustomDate
}

struct CustomDate: Codable, Equatable {
    let date: Date

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let year = try container.decode(Int.self)
        let month = try container.decode(Int.self)
        let day = try container.decode(Int.self)

        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date components")
        }

        self.date = date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        try container.encode(components.year ?? 0)
        try container.encode(components.month ?? 0)
        try container.encode(components.day ?? 0)
    }
}
