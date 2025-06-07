import Combine

protocol FirstScreenAddingGoalViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var buttonState: ButtonState { get }
    var targetName: String { get }
    
    var buttonStatePublisher: Published<ButtonState>.Publisher { get }
    
    // MARK: Methods
    func setTargetName(name: String)
}

extension FirstScreenAddingGoalViewModel: FirstScreenAddingGoalViewModelProtocol {
    var buttonStatePublisher: Published<ButtonState>.Publisher { $buttonState }
}
