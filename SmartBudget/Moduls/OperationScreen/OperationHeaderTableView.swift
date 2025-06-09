import UIKit

final class OperationHeaderTableView: UIView {
    
    // MARK: UI Elements
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .mediumFontSize, weight: .bold)
        return label
    }()

    private lazy var spendTotalAmountForDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customGray2
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .medium)
        return label
    }()

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configure(day: DayInfo) {
        dayLabel.text = dateFormatter.string(from: day.day)
        spendTotalAmountForDayLabel.text = "\(day.totalSpendForDay.formattedWithoutDecimalIfWhole()) ₽"
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(dayLabel)
        addSubview(spendTotalAmountForDayLabel)
    }

    private func setupLayout() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.largePadding)
        }

        spendTotalAmountForDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
