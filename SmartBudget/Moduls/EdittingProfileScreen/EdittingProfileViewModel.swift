import Foundation
import Combine

final class EdittingProfileViewModel: EdittingProfileViewModelProtocol {

    // MARK: Published Properties
    @Published private(set) var isValid: Bool = false
    @Published private(set) var shouldShowClue: Bool = false
    @Published private(set) var user: User

    // MARK: Properties
    private(set) var sections = ["Основная информация"]
    private(set) var items: [String] = ["Имя", "Фамилия", "День зарплаты", "Сумма зарплаты"]
    
    private let nameRegex = "^[\\p{L}\\-'\\s]+$"
    private let minLenght = 2
    private let maxLenght = 50
    private let minSalaryDay = 1
    private let maxSalaryDay = 31
    private let minSalaryAmount = 0
    
    // MARK: Initialization
    init(user: User) {
        self.user = user
    }
    
    // MARK: Public Methods
    func updateValidationStatus(name: String, lastName: String, salaryDay: String, salaryAmount: String) {
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
        
        guard let salaryDayInt = Int(salaryDay),
              salaryDayInt >= minSalaryDay && salaryDayInt <= maxSalaryDay else {
            isValid = false
            shouldShowClue = true
            return
        }
        
        guard let salaryAmountInt = Int(salaryAmount),
              salaryAmountInt >= minSalaryAmount else {
            isValid = false
            shouldShowClue = true
            return
        }
        
        if name.range(of: nameRegex, options: .regularExpression) != nil && lastName.range(of: nameRegex, options: .regularExpression) != nil {
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

    func updateUser(name: String, lastName: String, salaryDay: Int, salaryAmount: Int) {
        user.name = name
        user.lastName = lastName
        user.dayOfSalary = salaryDay
        user.income = salaryAmount
    }
}
