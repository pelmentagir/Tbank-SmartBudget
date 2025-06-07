import Combine
import Foundation

protocol SavingViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var savingGoals: [SavingGoal] { get set }
    var savingGoalsPublisher: Published<[SavingGoal]>.Publisher { get }
    
    // MARK: Methods
    func replenishCartainSavingGoal(_ savingGoal: SavingGoal)
    func calculateMonthlySaving(for goal: SavingGoal, currentDate: Date) -> Int
}

extension SavingViewModel: SavingViewModelProtocol {
    var savingGoalsPublisher: Published<[SavingGoal]>.Publisher { $savingGoals }
}
