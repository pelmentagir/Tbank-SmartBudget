import UIKit

private extension String {
    static let stepText = "Шаг 3 из 3"
    static let titleText = "Выберите дату достижения цели"
    static let toGoalText = "До даты накопления: "
    static let day = "0 дней"
}

private extension CGFloat {
    static let normalPadding: CGFloat = 24
}

final class ThirdScreenAddingGoalView: UIView {

    // MARK: Properties
    private let buttonFactory: IButtonFactory

    // MARK: UI Elements
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .defaultFontSize)
        label.text = .stepText
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .highFontSize)
        label.numberOfLines = 2
        label.text = .titleText
        return label
    }()

    private(set) lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Calendar.current.startOfDay(for: Date())
        picker.locale = Locale(identifier: LocaleIdentifier.ru.identifier)
        return picker
    }()

    private(set) lazy var continueButton: IButton = buttonFactory.createButton(
        type: .standard,
        title: .confirmButtonText,
        state: .normal,
        font: .systemFont(ofSize: .defaultFontSize),
        height: .baseHeight)

    private lazy var toGoalLabel: UILabel = {
        let label = UILabel()
        label.text = .toGoalText
        label.font = .systemFont(ofSize: .regularFontSize, weight: .medium)
        return label
    }()

    private lazy var toGoalValueLabel: UILabel = {
        let label = UILabel()
        label.text = .day
        label.font = .boldSystemFont(ofSize: .mediumFontSize)
        return label
    }()

    // MARK: Initialization
    init(buttonFactory: IButtonFactory) {
        self.buttonFactory = buttonFactory
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func setDaysRemaining(day: Int) {
        toGoalValueLabel.text = "\(day) дней"
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(datePicker)
        addSubview(toGoalLabel)
        addSubview(toGoalValueLabel)
        addSubview(continueButton)
    }

    private func setupLayout() {
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().offset(CGFloat.largePadding)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        toGoalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.extraLargePadding)
            make.leading.equalToSuperview().inset(CGFloat.normalPadding)
        }

        toGoalValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.extraLargePadding)
            make.leading.equalTo(toGoalLabel.snp.trailing).offset(CGFloat.extraSmallPadding)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
