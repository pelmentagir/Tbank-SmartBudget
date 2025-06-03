import Foundation

final class ProfileViewModel {
    @Published private(set) var user: User = User(name: "Олег", lastName: "Тинькофф", login: "tbank@gmail.com", birthDate: Date(), averageSpending: 50000, income: 100000, dayOfSalary: 25)
    
    private(set) var sections = ["Основная информация", "Настройки"]
    private(set) var mainInfoItems = ["Дата рождения", "День зарплаты", "Зарплата", "Средний расход"]
    private(set) var settingsItems = ["Тема приложения"]
}
