import Foundation

final class MainViewModel {
    @Published var chartItems: [ChartItem] = [
        .init(label: "Еда", value: 35000),
        .init(label: "Транспорт", value: 20000),
        .init(label: "Жильё", value: 30000),
        .init(label: "Развлечения", value: 15000)
    ]
    
    
}
