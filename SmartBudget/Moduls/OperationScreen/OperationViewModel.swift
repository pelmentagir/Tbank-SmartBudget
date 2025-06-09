import Foundation

final class OperationViewModel {
    // MARK: Published Properties
    @Published private(set) var operation: Operation

    // MARK: Initialization
    init() {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        self.operation = Operation(totalSpentMoney: 14000, daysInfo: [
            DayInfo(day: today, totalSpendForDay: 7000, categoryDetailsForDay: [
                CategoryDetailsForDay(categoryName: "Продукты питания", spendMoney: 4000),
                CategoryDetailsForDay(categoryName: "Развлечения", spendMoney: 3000)
            ]),
            DayInfo(day: yesterday, totalSpendForDay: 7000, categoryDetailsForDay: [
                CategoryDetailsForDay(categoryName: "Продукты питания", spendMoney: 4000),
                CategoryDetailsForDay(categoryName: "Развлечения", spendMoney: 3000)
            ])
        ])
    }

    // MARK: Public Methods
    func getDayInfo(for section: Int) -> DayInfo? {
        guard section < operation.daysInfo.count else { return nil }
        return operation.daysInfo[section]
    }
}
