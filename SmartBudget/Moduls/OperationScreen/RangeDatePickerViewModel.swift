import Foundation

final class RangeDatePickerViewModel {

    // MARK: Properties
    private(set) var startDate: Date?
    private(set) var endDate: Date?

    var selectedRangeText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: LocaleIdentifier.ru.identifier)

        if let start = startDate, let end = endDate {
            return "\(formatter.string(from: start)) — \(formatter.string(from: end))"
        } else if let start = startDate {
            return formatter.string(from: start)
        } else {
            return "Выберите диапазон дат"
        }
    }

    // MARK: Public Methods
    func handleDateSelection(_ date: Date) {
        switch (startDate, endDate) {
        case (nil, _):
            startDate = date
            endDate = nil
        case (let start?, nil):
            if date < start {
                endDate = start
                startDate = date
            } else {
                endDate = date
            }

        default:
            resetSelection()
            startDate = date
        }
    }

    func resetSelection() {
        startDate = nil
        endDate = nil
    }

    func getSelectedRange() -> (start: Date?, end: Date?) {
        return (startDate, endDate)
    }
}
