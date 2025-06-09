import Combine

protocol OperationViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var operation: Operation { get }
    
    var operationPublisher: Published<Operation>.Publisher { get }
    
    // MARK: Methods
    func getDayInfo(for section: Int) -> DayInfo?
}

extension OperationViewModel: OperationViewModelProtocol {
    var operationPublisher: Published<Operation>.Publisher { $operation }
}
