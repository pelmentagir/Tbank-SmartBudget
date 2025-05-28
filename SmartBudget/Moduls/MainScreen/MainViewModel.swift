import Foundation

final class MainViewModel {
    @Published var chartItems: [CategorySpendingDTO] = [
        .init(categoryName: "Продукты питания", spentMoney: 2500, leftMoney: 3000, percent: 30),
        .init(categoryName: "Рестораны и кафе", spentMoney: 2500, leftMoney: 3000, percent: 30),
        .init(categoryName: "Одежда и обувь", spentMoney: 2500, leftMoney: 3000, percent: 30),
        .init(categoryName: "Товары для дома", spentMoney: 2500, leftMoney: 3000, percent: 30)
    ]
}
