import Combine

protocol EdittingProfileViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var isValid: Bool { get }
    var shouldShowClue: Bool { get }
    var user: User { get }
    
    var sections: [String] { get }
    var items: [String] { get }

    var isValidPublisher: Published<Bool>.Publisher { get }
    var shouldShowCluePublisher: Published<Bool>.Publisher { get }
    var userPublisher: Published<User>.Publisher { get }

    // MARK: Methods
    func updateValidationStatus(name: String, lastName: String, salaryDay: String, salaryAmount: String)
    func hideClue()
    func updateUser(name: String, lastName: String, salaryDay: Int, salaryAmount: Int)
}

extension EdittingProfileViewModel {
    var isValidPublisher: Published<Bool>.Publisher { $isValid }
    var shouldShowCluePublisher: Published<Bool>.Publisher { $shouldShowClue }
    var userPublisher: Published<User>.Publisher { $user }
}
