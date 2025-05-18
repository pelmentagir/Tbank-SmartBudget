import Foundation

class CreateProfileViewModel {

    // MARK: Published Properties
    @Published private(set) var isValid: Bool = false
    @Published private(set) var shouldShowClue: Bool = false

    // MARK: Properties
    private var nameRegex = "^[\\p{L}\\-'\\s]+$"
    private var minLenght = 2
    private var maxLenght = 50

    // MARK: Public Methods
    func updateValidationStatus(name: String, lastName: String) {
        guard name.count > minLenght && name.count <= maxLenght else {
            isValid = false
            shouldShowClue = true
            return
        }
        guard lastName.count > minLenght && lastName.count <= maxLenght else {
            isValid = false
            shouldShowClue = true
            return
        }

        if name.range(of: nameRegex, options: .regularExpression) != nil && lastName .range(of: nameRegex, options: .regularExpression) != nil {
            isValid = true
            shouldShowClue = false
        } else {
            isValid = false
            shouldShowClue = true
        }
    }

    func hideClue() {
        shouldShowClue = false
    }
}
