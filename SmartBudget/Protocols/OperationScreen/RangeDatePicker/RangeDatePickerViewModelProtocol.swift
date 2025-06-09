import Foundation

protocol RangeDatePickerViewModelProtocol: AnyObject {
    // MARK: Properties
    var startDate: Date? { get }
    var endDate: Date? { get }
    var selectedRangeText: String { get }
    
    // MARK: Methods
    func handleDateSelection(_ date: Date)
    func resetSelection()
    func getSelectedRange() -> (start: Date?, end: Date?)
}
