import Combine

protocol OperationViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var spendingResponse: SpendingResponse { get }
    var progress: Float { get }

    var spendingResponsePublisher: Published<SpendingResponse>.Publisher { get }
    var progressPublisher: Published<Float>.Publisher { get }
    var updateTable: (() -> Void)? { get set }

    // MARK: Methods
    func getDayInfo(for section: Int) -> DayInfo?
    func fetchSpendingData(request: SpendingRequest)
}

extension OperationViewModel: OperationViewModelProtocol {
    var spendingResponsePublisher: Published<SpendingResponse>.Publisher { $spendingResponse }
    var progressPublisher: Published<Float>.Publisher { $progress }
}
