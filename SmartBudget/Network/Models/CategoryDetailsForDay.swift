import Foundation

struct CategoryDetailsForDay: Codable, Hashable {
    let categoryName: String
    let spentMoney: Double
    var id = UUID()

    enum CodingKeys: String, CodingKey {
        case categoryName, spentMoney

    }
}

struct DayInfo: Codable {
    let day: String
    let totalSpendForDay: Double
    let categoryDetailsForDay: [CategoryDetailsForDay]

    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: day)
    }
}

struct SpendingResponse: Codable {
    let totalSpentMoney: Double
    let userIncome: Double?
    let daysInfo: [DayInfo]
}
