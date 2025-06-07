import Foundation

final class MainViewModel {

    // MARK: Published Properties
    @Published var chartItems: [CategorySpending] = [
        .init(categoryName: "Продукты питания", spentMoney: 2500, leftMoney: 3000, percent: 40),
        .init(categoryName: "Рестораны и кафе", spentMoney: 2500, leftMoney: 3000, percent: 30),
        .init(categoryName: "Одежда и обувь", spentMoney: 2500, leftMoney: 3000, percent: 15),
        .init(categoryName: "Товары для дома", spentMoney: 2500, leftMoney: 3000, percent: 15)
    ]

    @Published var spentIncome: Int = 10000
    @Published var leftIncome: Int = 12000
}
