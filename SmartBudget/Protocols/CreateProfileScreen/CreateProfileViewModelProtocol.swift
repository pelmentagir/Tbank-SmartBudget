import Combine

protocol CreateProfileViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var isValid: Bool { get }
    var shouldShowClue: Bool { get }

    var isValidPublisher: Published<Bool>.Publisher { get }
    var shouldShowCluePublisher: Published<Bool>.Publisher { get }

    // MARK: Methods
    func updateValidationStatus(name: String, lastName: String)
    func hideClue()
}

extension CreateProfileViewModel: CreateProfileViewModelProtocol {
    var isValidPublisher: Published<Bool>.Publisher { $isValid }
    var shouldShowCluePublisher: Published<Bool>.Publisher { $shouldShowClue }
}
