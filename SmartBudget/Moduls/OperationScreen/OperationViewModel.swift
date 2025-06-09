import Foundation
import Combine

final class OperationViewModel {

    // MARK: Published Properties
    @Published private(set) var spendingResponse: SpendingResponse = SpendingResponse(totalSpentMoney: 0, userIncome: nil, daysInfo: []) {
        didSet {
            updateTable?()
            updateProgress()
        }
    }

    @Published private(set) var progress: Float = 0.0
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    var updateTable: (() -> Void)?

    private let networkService = NetworkService.shared

    // MARK: Initialization
    init() {
        let request = SpendingRequest(startDate: "2025-05-05", endDate: "2025-06-10")
        fetchSpendingData(request: request)
    }

    // MARK: Private Methods
    private func updateProgress() {
        guard let income = spendingResponse.userIncome else {
            progress = 0.0
            return
        }
        progress = Float(spendingResponse.totalSpentMoney) / Float(income)
    }

    // MARK: Public Methods
    func getDayInfo(for section: Int) -> DayInfo? {
        guard section < spendingResponse.daysInfo.count else { return nil }
        return spendingResponse.daysInfo[spendingResponse.daysInfo.count - section - 1]
    }

    // MARK: Network Request
    func fetchSpendingData(request: SpendingRequest) {
        isLoading = true
        error = nil

        let endpoint = SpendingEndpoint(request: request)

        networkService.request(endpoint, responseType: SpendingResponse.self) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):

                self.spendingResponse = response

            case .failure(let error):
                self.error = error
                print("Error fetching spending data: \(error.localizedDescription)")
            }
        }
    }
}
