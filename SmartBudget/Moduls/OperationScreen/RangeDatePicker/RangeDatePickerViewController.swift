import UIKit
import FSCalendar

final class RangeDatePickerViewController: UIViewController, FlowController {

    private var rangeDatePickerView: RangeDatePickerView {
        self.view as! RangeDatePickerView
    }

    // MARK: Properties
    private let viewModel: RangeDatePickerViewModelProtocol
    var completionHandler: ((Int) -> Void)?
    
    private lazy var doneButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        let (start, end) = viewModel.getSelectedRange()
        if let start = start, let end = end {
            print("Выбран диапазон: \(viewModel.selectedRangeText)")
        } else if let start = start {
            print("Выбрана одна дата: \(viewModel.selectedRangeText)")
        } else {
            print("Диапазон не выбран")
        }
        dismiss(animated: true)
    }

    // MARK: Actions
    private lazy var cancelButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.resetSelection()
        updateUI()
        dismiss(animated: true)
    }

    init(viewModel: RangeDatePickerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func loadView() {
        view = RangeDatePickerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupActions()
    }

    // MARK: Public Methods
    func configurePresentation() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
    }

    // MARK: Private Methods
    private func setupBindings() {
        rangeDatePickerView.calendar.dataSource = self
        rangeDatePickerView.calendar.delegate = self
    }

    private func setupActions() {
        rangeDatePickerView.doneButton.addAction(doneButtonTapped, for: .touchUpInside)
        rangeDatePickerView.cancelButton.addAction(cancelButtonTapped, for: .touchUpInside)
    }

    private func updateUI() {
        rangeDatePickerView.rangeLabel.text = viewModel.selectedRangeText
        let (start, end) = viewModel.getSelectedRange()
        rangeDatePickerView.updateSelectedDates(startDate: start, endDate: end)
    }
}

// MARK: - FSCalendarDelegate & DataSource
extension RangeDatePickerViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.handleDateSelection(date)
        updateUI()
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.resetSelection()
        updateUI()
    }
}
