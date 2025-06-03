import Foundation

final class ThirdScreenAddingGoalViewModel {

    // MARK: Published Properties
    @Published private(set) var daysDifference: Int?

    // MARK: Properties
    private(set) var selectedDay = Date()

    // MARK: Public Methods
    func setSelectedDay(day: Date) {
        selectedDay = day
        let currentDate = Date()

        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day],
            from: currentDate,
            to: selectedDay
        )

        daysDifference = (components.day ?? 0) + 1
    }
}
