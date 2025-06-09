import UIKit
import FSCalendar

private extension CGFloat {
    static let calendarHeight: CGFloat = 350
}

private extension String {
    static let rangeText = "Выберите диапазон дат"
    static let cancelText = "Отмена"
    static let doneText = "Готово"
}

final class RangeDatePickerView: UIView {

    // MARK: UI Elements
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.selectionColor = .systemBlue
        calendar.appearance.todayColor = .systemRed
        calendar.locale = Locale(identifier: LocaleIdentifier.ru.identifier)
        return calendar
    }()

    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(.doneText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .defaultFontSize, weight: .bold)
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(.cancelText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .defaultFontSize, weight: .bold)
        return button
    }()

    lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.text = .rangeText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func updateSelectedDates(startDate: Date?, endDate: Date?) {
        guard let start = startDate else { return }

        calendar.selectedDates.forEach { calendar.deselect($0) }
        calendar.select(start)

        if let end = endDate, start <= end {
            var date = start
            while date <= end {
                calendar.select(date)
                guard let next = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                date = next
            }
        }
    }

    // MARK: Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(buttonsStackView)
        addSubview(rangeLabel)
        addSubview(calendar)
        setupConstraints()
    }

    private func setupConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        rangeLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        calendar.snp.makeConstraints { make in
            make.top.equalTo(rangeLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.height.equalTo(CGFloat.calendarHeight)
        }
    }
}
