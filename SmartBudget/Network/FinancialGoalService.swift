import Foundation

protocol FinancialGoalServiceProtocol {
    func createGoal(
        from request: SavingGoalRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

final class FinancialGoalService: FinancialGoalServiceProtocol {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func createGoal(
        from request: SavingGoalRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let endDate = request.endDate else {
            completion(.failure(NSError(domain: "End date is missing", code: 0)))
            return
        }

        let imageData = request.image?.jpegData(compressionQuality: 0.8) ?? Data()
        let goalData = FinancialGoalData(
            name: request.title,
            amount: Double(request.totalCost),
            progress: Double(request.accumulatedMoney),
            startDate: formatter.string(from: request.startDate),
            endDate: formatter.string(from: endDate),
            imageData: imageData,
            imageName: "goal.jpg",
            mimeType: "image/jpeg"
        )

        networkService.uploadFinancialGoal(data: goalData, completion: completion)
    }
}
