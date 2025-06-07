import Combine
import Foundation

protocol ThirdScreenAddingGoalViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var daysDifference: Int? { get }
    var selectedDay: Date { get }
    
    var daysDifferencePublisher: Published<Int?>.Publisher { get }
    
    // MARK: Methods
    func setSelectedDay(day: Date)
}

extension ThirdScreenAddingGoalViewModel: ThirdScreenAddingGoalViewModelProtocol {
    var daysDifferencePublisher: Published<Int?>.Publisher { $daysDifference }
}
