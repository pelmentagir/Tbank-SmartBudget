import Foundation

final class ProfileViewModel {

    // MARK: Published Properties
    @Published private(set) var user: User = User(name: "Олег", lastName: "Тиньков", login: "tbank@gmail.com", birthDate: Date(), averageSpending: 50000, income: 100000, dayOfSalary: 25)

    // MARK: Properties
    private(set) var sections = ["Основная информация", "Настройки"]
    private(set) lazy var mainInfoItems = [
        "Дата рождения: ",
        "День зарплаты: ",
        "Зарплата: ",
        "Средний расход: "
    ]

    private(set) var settingsItems = ["Тема приложения", "Изменить выбранные категории"]

    // MARK: Public Methods
    func getInfoUserAtIndex(index: Int) -> String {
        switch index {
        case 0: return formatDate(user.birthDate)
        case 1: return "\(user.dayOfSalary) день"
        case 2: return "\(user.income) ₽"
        default: return "\(user.averageSpending) ₽"
        }
    }

    func getCurrentUser() -> User {
        return user
    }

    func changeUser(_ user: User) {
        self.user = user
    }

    // MARK: Private Methods
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
