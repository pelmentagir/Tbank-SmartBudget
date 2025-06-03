import UIKit

final class FirstScreenAddingGoalViewModel {

    // MARK: Published Properties
    @Published private(set) var buttonState: ButtonState = .disabled

    // MARK: Properties
    private(set) var targetName: String = ""

    // MARK: Public Methods
    func setTargetName(name: String) {
        buttonState = name.isEmpty ? .disabled : .normal
        targetName = name
    }
}
