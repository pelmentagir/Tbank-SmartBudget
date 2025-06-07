import Combine

protocol ProfileViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var user: User { get }
    var userPublisher: Published<User>.Publisher { get }

    // MARK: Properties
    var sections: [String] { get }
    var mainInfoItems: [String] { get }
    var settingsItems: [String] { get }

    // MARK: Methods
    func getInfoUserAtIndex(index: Int) -> String
    func getCurrentUser() -> User
    func changeUser(_ user: User)
}

extension ProfileViewModel: ProfileViewModelProtocol {
    var userPublisher: Published<User>.Publisher { $user }
}
