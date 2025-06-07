import Foundation

protocol SavingTargetTableViewCellProtocol: AnyObject {
    func configureCell(item: SavingGoal, monthlySaving: Int, onReplenish: @escaping () -> Void)
}
