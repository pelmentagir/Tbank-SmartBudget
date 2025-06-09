import Foundation

final class MainViewModel {

    // MARK: - Published Properties
    @Published var chartItems: [CategorySpending] = []
    @Published var spentIncome: Int = 0
    @Published var leftIncome: Int = 0

    init() {
        fetchMainData()
    }

    // MARK: Network
    func fetchMainData() {
        let endpoint = GetMainDataEndpoint()

        NetworkService.shared.request(endpoint, responseType: MainDataResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.spentIncome = response.spentIncome
                    self?.leftIncome = response.leftIncome
                    self?.chartItems = response.categoryDetailsDtoList
                }
            case .failure(let error):
                print("Ошибка при получении данных главного экрана: \(error.localizedDescription)")
            }
        }
    }
}
