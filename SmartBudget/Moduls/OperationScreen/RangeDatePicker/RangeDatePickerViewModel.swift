import Foundation

final class RangeDatePickerViewModel: RangeDatePickerViewModelProtocol {

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

    func createSpendingRequest(start: Date?, end: Date?) -> SpendingRequest? {
        guard let start = start, let end = end else {
            return nil
        }
        print(start)
        print(end)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let correctedStart = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let correctedEnd = Calendar.current.date(byAdding: .day, value: 1, to: end)!

        let startDateString = dateFormatter.string(from: correctedStart)
        let endDateString = dateFormatter.string(from: correctedEnd)

        return SpendingRequest(startDate: startDateString, endDate: endDateString)
    }
}
